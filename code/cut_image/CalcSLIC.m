function out = CalcSLIC(Img_in, K_in, M_in, Thres_in)
% 输入为图片，聚类数，距离权重，及阈值
% 输出为聚类标签，及最终图片效果

% 读入图片及预处理
I_rgb = im2double(Img_in);
I_lab = rgb2lab(I_rgb);
I_size = size(I_lab);
row = I_size(1);
column = I_size(2);
% 超像素数及距离权重
K = K_in;
M = M_in;
% 2S定值
S = floor(sqrt(row * column / K));
% 聚类坐标
clus_cent = zeros(K,2);
% 最终分割图
label = zeros(row, column);
% 所有像素的距离设为无穷大
distance = Inf(row, column);
% 索引
main_index = 0;
% 计算各聚类中心坐标
for i = floor(S/2):S:row
    for j = floor(S/2):S:column
        main_index = main_index + 1;
        clus_cent(main_index,1) = i;
        clus_cent(main_index,2) = j;
    end
end
% 更新聚类数
K = main_index;
% 移除多余中心坐标
clus_cent = clus_cent(1:K, :);
% 残差
resi = Inf;
% 阈值限制
while resi > Thres_in
    % 对所有聚类操作
    for main_index = 1:K
        % 当前聚类的坐标
        clus_cent_x = clus_cent(main_index, 2);
        clus_cent_y = clus_cent(main_index, 1);
        % 对2S*2S区域内的像素
        for i = clus_cent_y - S:clus_cent_y + S
            % 刨除超出图像范围的
            if i < 1 || i > row
                continue;
            end
            for j = clus_cent_x - S:clus_cent_x + S
                % 刨除超出图像范围的
                if j < 1 || j > column
                    continue;
                end
                % Lab空间的中心点坐标
                clus_cent_l = I_lab(clus_cent_y, clus_cent_x, 1);
                clus_cent_a = I_lab(clus_cent_y, clus_cent_x, 2);
                clus_cent_b = I_lab(clus_cent_y, clus_cent_x, 3);
                % 当前像素的坐标
                pos_l = I_lab(i, j, 1);
                pos_a = I_lab(i, j, 2);
                pos_b = I_lab(i, j, 3);
                % 该点与中心在Lab空间的距离
                dis_lab = sqrt((clus_cent_l - pos_l) ^ 2 + (clus_cent_a - pos_a) ^ 2 + (clus_cent_b - pos_b) ^ 2);
                % 该点与中心在xy空间的距离
                dis_xy = sqrt((clus_cent_y - i) ^ 2 + (clus_cent_x - j) ^ 2);
                % 权重因子与xy空间距离的综合
                dis_mxy = (M * dis_xy / S);
                % 总距离
                dist = sqrt(dis_lab ^ 2 + dis_mxy ^ 2);
                % 小于当前距离，更新其所属聚类和距离
                if dist < distance(i,j)
                    label(i,j) = main_index;
                    distance(i,j) = dist;
                end
            end
        end
    end
    % 更新聚类
    clus_cent_temp = clus_cent;
    % 对所有聚类操作
    for main_index = 1:K
        sum_x = 0;
        sum_y = 0;
        % 找到归属于这一类的像素
        indexs = find(label == main_index);
        % 所有像素坐标求和
        for idx = 1:length(indexs)
            sum_x = sum_x + floor(indexs(idx)/row) + 1;
            sum_y = sum_y + indexs(idx) - floor(indexs(idx)/row)*row;
        end
        % 总坐标除以坐标数，即为中心点坐标
        new_clus_cent_x = floor(sum_x / length(indexs));
        new_clus_cent_y = floor(sum_y / length(indexs));
        clus_cent(main_index,2) = new_clus_cent_x;
        clus_cent(main_index,1) = new_clus_cent_y;
    end
    % 残差计算
    minus_x = clus_cent(:,2) - clus_cent_temp(:,2);
    minus_y = clus_cent(:,1) - clus_cent_temp(:,1);
    resi = sum(minus_x .^ 2) + sum(minus_y .^ 2);
end
out = label;
end

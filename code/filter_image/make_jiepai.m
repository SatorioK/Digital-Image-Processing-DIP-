function out_img = make_jiepai(I)

lut_map = imread('..\..\data\jiepai.jpg');

% 转换lut的数据存储格式
lut_cell_1 = mat2cell(lut_map(:,:,1),[64,64,64,64,64,64,64,64],[64,64,64,64,64,64,64,64]);
lut_cell_2 = mat2cell(lut_map(:,:,2),[64,64,64,64,64,64,64,64],[64,64,64,64,64,64,64,64]);
lut_cell_3 = mat2cell(lut_map(:,:,3),[64,64,64,64,64,64,64,64],[64,64,64,64,64,64,64,64]);
lut = zeros(512*512,3);
for i = 1:8
    for j = 1:8
        cell = cat(3,lut_cell_1{i,j}',lut_cell_2{i,j}',lut_cell_3{i,j}');
        lut(1+((i-1)*8+j-1)*64*64:((i-1)*8+j)*64*64,:) = reshape(cell,64*64,3);
    end
end
% 施加滤镜模板
out_img = imlut(I, lut, '3D', 'standard', 'BGR');
end
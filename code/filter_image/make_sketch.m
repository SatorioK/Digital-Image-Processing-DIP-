function out_img = make_sketch(img)

I = double(img);
sobel = fspecial('sobel');
sobel_rev = sobel';
Rx = imfilter(I(:,:,1), sobel, 'replicate');
Ry = imfilter(I(:,:,1), sobel_rev, 'replicate');
Gx = imfilter(I(:,:,2), sobel, 'replicate');
Gy = imfilter(I(:,:,2), sobel_rev, 'replicate');
Bx = imfilter(I(:,:,3), sobel, 'replicate');
By = imfilter(I(:,:,3), sobel_rev, 'replicate');
R_res = sqrt(Rx.^2 + Ry.^2);
G_res = sqrt(Gx.^2 + Gy.^2);
B_res = sqrt(Bx.^2 + By.^2);
res_rev = mat2gray(R_res + G_res + B_res);
res = 255 - im2uint8(res_rev);
[M, N] = size(res);
final_res = zeros(M, N);
for i = 1:M
    for j = 1:N
        % 作为边缘的区域
        if res(i, j) < 180
            final_res(i, j) = (180 - final_res(i, j)) / 5;
        % 其他区域
        else
            final_res(i, j) = 3 * (res(i, j) - 180);
        end
    end
end
out_img = uint8(final_res);
end

%% 初始化
clc;
close all;
clear;

%% 读取图片
addpath(genpath('..\filter_image'));
source_I = imread('..\..\data\source image.jpg');
template_I = imread('..\..\data\画作530.jpg');

%% 图片大小变化与风格变化
figure, imshow(template_I), title('请选择要替换区域的四个点');
[M, N, ~] = size(template_I);
source_I = make_sketch(imresize(source_I, [M, N]));

%% 空间变换
select_points = ginput(4);
origin_points = [1 1; N 1; 1 M; N M];
converted_I = morph_tps_wrapper(source_I, template_I, origin_points, select_points);
close;

%% 利用蒙版将图片放进原图中
mask = double(im2gray(imread('..\..\data\mask画作530.jpg'))) / 255;
converted_I = double(converted_I);
template_I = double(template_I);
converted_I(:,:,1) = converted_I(:,:,1) .* mask + template_I(:,:,1) .* (1 - mask);
converted_I(:,:,2) = converted_I(:,:,2) .* mask + template_I(:,:,2) .* (1 - mask);
converted_I(:,:,3) = converted_I(:,:,3) .* mask + template_I(:,:,3) .* (1 - mask);
figure,imshow(uint8(converted_I));
imwrite(uint8(converted_I), '画作替换后结果.jpg');

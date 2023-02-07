%% 初始化
clc;
close all;
clear;

%% 读取与显示
source_I = imread('..\..\data\source image.jpg');
I1 = make_jiepai(source_I);
I2 = make_sketch(source_I);
I3 = make_old(source_I);
figure, 
subplot(2, 2, 1), imshow(source_I), title('原图');
subplot(2, 2, 2), imshow(I1), title('街拍风格');
subplot(2, 2, 3), imshow(I2), title('素描风格');
subplot(2, 2, 4), imshow(uint8(I3)), title('怀旧风格');

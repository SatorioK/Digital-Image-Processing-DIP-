%% 初始化
clc;
close all;
clear;

%% SLIC与标记前背景
I = imread('..\..\data\画作530.jpg');
L = CalcSLIC(I, 530, 30, 3);
figure, imshow(I,[]);

[~, x, y] = drawline('color','r','linewidth',3);
x = ceil(x(:)); y = ceil(y(:));
foregroundInd = sub2ind(size(L), y, x);
[~, x, y] = drawline('color','b','linewidth',3);
x = ceil(x(:)); y = ceil(y(:));
backgroundInd = sub2ind(size(L), y, x);

%% 分割与显示
BW = lazysnapping(I, L, foregroundInd, backgroundInd);
% figure, imshow(BW);
imwrite(BW, 'mask.jpg');

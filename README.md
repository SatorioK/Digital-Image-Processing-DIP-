最后一次大作业


包括文件夹code及报告pdf版；

code文件夹内容：
cut_image为获取蒙版mask的内容，
内部包括2个函数文件和1个主函数文件，
CalcSLIC为SLIC算法函数，为后续分割提供标签；
drawline为标记函数，用于在原图标记前背景；
cut_image_main为主函数，用于蒙版mask制取，
要查看结果，直接运行这个文件即可。

filter_image为风格变换的内容，
内部包括4个函数文件和1个主函数文件，
make_old为怀旧风格变换函数；
make_sketch为素描风格变换函数；
make_jiepai为街拍风格变换函数；
imlut为街拍变换中使用到的LUT方法函数；
filter_test为测试效果的函数，在figure中生成原图和所有风格的图片比较，
要查看结果，直接运行这个文件即可。

change_image为空间变换的内容，
内部包括4个函数文件和3个主函数文件，
est_tps用于参数矩阵的求解；
pixel_limit用于约束图像边界，防止越界；
morph_tps为算法的主要内容，即空间变形的内容；
morph_tps_wrapper为用于外部调用的函数，综合调用上述函数；
work_01~03均为变换内容，用于外部输入点以进行变换，
要查看结果，直接运行这三个文件即可。


说明完毕。

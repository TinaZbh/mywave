clc;clear;
a = magic(8)
b = Horizontal_interpolation(a,4);
[a,c] = Horizontal_Direction_Prediction(a,b);
a
b = Horizontal_interpolation(a,4);
[a,ori_QuartPixel_interp] = Horizontal_Update(a,b,c);
a
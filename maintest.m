clc;
clear;
origin  = imread('barb.bmp');
[MyHeight,MyWidth] = size(origin);
%�б任
ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin); %��ֵ
[origin,Predict_direc_H] = Horizontal_Direction_Prediction(origin,ori_QuartPixel_interp);%Ԥ��

ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);%��ֵ
origin = Horizontal_Update(origin,ori_QuartPixel_interp,Predict_direc_H);%����

origin = origin';
%�б任
ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);
[origin,Predict_direc_V] = Horizontal_Direction_Prediction(origin,ori_QuartPixel_interp);

ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);
origin = Horizontal_Update(origin,ori_QuartPixel_interp,Predict_direc_V);
origin = origin';

origin1 = abs(origin);
origin1 = uint8(origin1);
figure(2)
subplot(121),imshow(origin1);
%����任
origin = origin';

ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);%��ֵ
origin = inverse_Horizontal_Update(origin,ori_QuartPixel_interp,Predict_direc_V);%�����
ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);%��ֵ
origin = inverse_Horizontal_Prediction(origin,ori_QuartPixel_interp,Predict_direc_V);%��Ԥ��
%����任
origin = origin';

ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);
origin = inverse_Horizontal_Update(origin,ori_QuartPixel_interp,Predict_direc_H);
ori_QuartPixel_interp  = Horizontal_Sinc_interpolation(origin);
origin = inverse_Horizontal_Prediction(origin,ori_QuartPixel_interp,Predict_direc_H);

origin1 = abs(origin);
origin1 = uint8(origin1);
subplot(122),imshow(origin1);



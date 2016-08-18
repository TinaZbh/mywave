clc;
im = double(imread('barb.bmp'));

[im_h,im_w] = size(im);
[c,s]=wavedec2(im,1,'db5');
ca1=wcodemat(appcoef2(c,s,'db5',1),255);%��ȡС���ֽ��еĵ�Ƶϵ����LL��
ch1=wcodemat(detcoef2('h',c,s,1),255);%��ȡˮƽ����(HL)
cv1=wcodemat(detcoef2('v',c,s,1),255);%��ȡ��ֱ����(LH)
cd1=wcodemat(detcoef2('d',c,s,1),255);%��ȡб�߷���(HH)
c1=uint8([ca1,ch1;cv1,cd1]);%uint8��ʾ��Χ��0 255��
figure(1);
subplot(121);
imshow(c1);
title('�ֽ�ͼ��');
result_im = waverec2(c,s,'db5');
subplot(122);
imshow(uint8(result_im));
title('�ع�ͼ��');




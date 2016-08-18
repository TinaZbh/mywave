function [origin] = inverse_Horizontal_Prediction(origin,ori_QuartPixel_interp,Predict_direc)
[MyHeight,MyWidth] = size(origin);
M = 8;N = 8;
% 前MyHeight-1行
for j = 1:MyWidth
    for i =2:2:MyHeight-1
        k=Predict_direc(ceil(i/M),ceil(j/N));%%%%%%%%%%%%
        temp=ori_QuartPixel_interp(i,4*j-3);
        x=4*j+k-3;
        y=4*j-k-3;
        if x<1
            x=-x+2;
        end
        if y<1
            y=-y+2;
        end
        if x>4*MyWidth
            x=4*MyWidth-7;
        end
        if y>4*MyWidth
            y=4*MyWidth-7;
        end
        temp1=ori_QuartPixel_interp(i-1,x);
        temp2=ori_QuartPixel_interp(i+1,y);
        ori_QuartPixel_interp(i,4*j-3)=temp+(temp1+temp2)/2;
    end
end

% 第MyHeight行
for j = 1:MyWidth
        k=Predict_direc(ceil(MyHeight/M),ceil(j/N));%%%%%%%%%%%%
        temp=ori_QuartPixel_interp(MyHeight,4*j-3);
        x=4*j+k-3;
        y=4*j-k-3;
        if x<1
            x=-x+2;
        end
        if y<1
            y=-y+2;
        end
        if x>4*MyWidth
            x=4*MyWidth-7;
        end
        if y>4*MyWidth
            y=4*MyWidth-7;
        end
        temp1=ori_QuartPixel_interp(MyHeight-1,x);
        temp2=ori_QuartPixel_interp(MyHeight-1,y);
        ori_QuartPixel_interp(MyHeight,4*j-3)=temp+(temp1+temp2)/2;
end

for i = 1:MyHeight
    for j=1:MyWidth
 		origin(i,j)=ori_QuartPixel_interp(i,4*j-3);
    end
end

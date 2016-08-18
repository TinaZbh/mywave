function [origin] = inverse_Horizontal_Update(origin,ori_QuartPixel_interp,Predict_direc)
[MyHeight,MyWidth] = size(origin);
M = 8;N = 8;
ttt = zeros(MyHeight);

for i = 1:MyWidth*4
    
    for j =1:MyHeight
        ttt(j)=ori_QuartPixel_interp(j,i);
    end
    
    for j = 1:MyHeight/2
        ori_QuartPixel_interp(2*j-1,i)=ttt(j);
        ori_QuartPixel_interp(2*j,i)=ttt(j+MyHeight/2);
    end
            
end
% 第1行更新
for j = 1:MyWidth
    k=Predict_direc(1,ceil(j/N));%%%%%%%%%%%%
    temp=ori_QuartPixel_interp(1,4*j-3);
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
    temp1=ori_QuartPixel_interp(2,x);
    temp2=ori_QuartPixel_interp(2,y);
    ori_QuartPixel_interp(1,4*j-3)=temp-(temp1+temp2)/4;   
end
% 后MyHeight-1行
for j = 1:MyWidth
    for i = 3:2:MyHeight
        k=Predict_direc(ceil(i/M),ceil(j/N));%%%%%%%%%%%%
    end
    temp=ori_QuartPixel_interp(i,4*j-3);
    x=4*j+k;
    y=4*j-k; 
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
    ori_QuartPixel_interp(i,4*j-3)=temp-(temp1+temp2)/4;   
end

for i = 1:MyHeight
    for j=1:MyWidth
 		origin(i,j)=ori_QuartPixel_interp(i,4*j-3);
    end
end

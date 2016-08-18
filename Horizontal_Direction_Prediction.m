function [origin,Predict_direc] = Horizontal_Direction_Prediction(origin,ori_QuartPixel_interp)

[MyHeight,MyWidth] = size(origin);
Dir = 4;
M=8;
N=8;
Predict_direc=zeros(MyHeight/M,MyWidth/N);
Block_energy=100000*ones(MyHeight/M,MyWidth/N);
 
for k=-Dir:Dir
    %     ǰMyHeight-1��
    for j=1:MyWidth
        for i=2:2:MyHeight-1
            temp=ori_QuartPixel_interp(i,4*j-3);
            x=4*j-3+k;
            y=4*j-3-k;
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
            ori_QuartPixel_interp(i,4*j-3)=temp-(temp1+temp2)/2;
        end
    end
     %     MyHeight��
    for j=1:MyWidth
        temp=ori_QuartPixel_interp(MyHeight,4*j);
        x=4*j-3+k;
        y=4*j-3-k;
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
        ori_QuartPixel_interp(MyHeight,4*j-3)=temp-(temp1+temp2)/2;
    end
    %     ����ĳ�������¿���Ԥ��в���С����    
    for i=1:MyHeight/M
        for j=1:MyWidth/N
            minEnergy_dir=0;
            for t1=2:2:M
                for t2=1:N
                    minEnergy_dir = minEnergy_dir + abs(ori_QuartPixel_interp((i-1)*M+t1,(j-1)*N*4+t2*4-3));
                end
            end 
            if minEnergy_dir < Block_energy(i,j)
                Block_energy(i,j)=minEnergy_dir;
                Predict_direc(i,j)=k;
           end
       end
    end
    %     ��ԭʼ����ֵд�ز�ֵ������飬����Ԥ��
    for i=1:MyHeight 
        for j=1:MyWidth 
        ori_QuartPixel_interp(i,j*4-3) = origin(i,j);
        end
    end
end
%-------------------------------------------  
% ǰMyHeight-1��
for j=1:MyWidth 
    for i=2:2:MyHeight-1
        k=Predict_direc(ceil(i/M),ceil(j/N));
        temp=ori_QuartPixel_interp(i,4*j-3);
        x=4*j-3+k;
        y=4*j-3-k;
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
        ori_QuartPixel_interp(i,4*j-3)=temp-(temp1+temp2)/2;
    end
end

% ��MyHeight��
for j=1:MyWidth 
    k=Predict_direc(ceil(MyHeight/M),ceil(j/N));
    temp=ori_QuartPixel_interp(MyHeight,4*j-3);
    x=4*j-3+k;
    y=4*j-3-k;
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
    ori_QuartPixel_interp(MyHeight,4*j-3)=temp-(temp1+temp2)/2;
end
	
for i=1:MyHeight
    for j=1:MyWidth 
    origin(i,j)=ori_QuartPixel_interp(i,4*j-3);
    end
end


                   
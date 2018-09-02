clc
clear all
A=load('F:/chaos/monthly rainfall number1.txt'); %使用相应数据的文件名。
x=A';%转化为行向量
%t=input('输入时间序列所要分成不相交的子序列的个数');
for t=1:20
    %t1=input(请输入子序列时间延迟ti=:')
    t1=1;
    n1=length(x);
    p=n1/t
    %m0=input(请输入嵌入维数m=;')
    St1=0;
    St2=0;
    x1=[];
    s=[];
    for m0=2:5
        for n=1:4
            for i=1:t
                x1(i,:)=x(1,i:t:n1-t+i);%将时间序列x分成t个不相交的子序列
                                        %对每个子序列重构相空间的点
                 y=[];
                 for j=1:p-(m0-1)*t1
                     y(j,:)=x1(i,j:t1:j+(m0-1)*t1);
                 end
                 %计算各嵌入时间子序列的关联积分cs(m.N,t,lt)以及关联维数
                 r=std(x)*n/2;
                 [h,l]=size(y);
                 Cr=0.01;
                 for k=1:h
                     for j=k+1:h
                         d(k,j)=r-norm(y(k,:)-y(j,:));
                         if d(k,j)>0
                             Cr=Cr+1;
                         end
                     end
                 end
                Cr1(i)=2*Cr/(h*(h-1));
                dm1(i)=log(Cr1(i))/log(r);
            end
            %计算c(1,Nn,r't)
            y1=x';
            r=std(x)*n/2;
            [h,l]=size(y1);
            Cr=0.01;
            for k=1:h
                for j=k+1:h
                    d(k,j)=r-norm(y1(k,:)-y1(j,:));
                    if d(k,j)>0
                        Cr=Cr+1;
                    end
                end
            end
            Cr2=2*Cr/(h*(h-1));
            dm2(i)=log(Cr1(i))/log(r);
            %计算s(m'N,r't)
            s=0;
            for g=1:t;
                
                
                s(1:g)=Cr1(1,g)-Cr2^m0;
            end
            S(m0-1,n)=sum(s)/t;
            St1=St1+S(m0-1,n);
        end
        St2=St2+max(S(m0-1,:))-min(S(m0-1,:));
    end
    S0(t)=max(max(S(m0-1,:)))-min(min(S(m0-1,:)));
    S1(t)=St1/16;
    S2(t)=St2/4;
    S3(t)=S1(t)+abs(S2(t));
end

plot(1:t,S0,1:t,S1,1:t,S2,1:t,S3)
legend('vS(m,t)','vS(t)','S(t)','Scor(t)')
                    
    

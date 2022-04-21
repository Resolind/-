function a = jiance(t,bps,A,fs,fangcha,N)
%fs需要是bps的倍数
%采样频率是生成信号速度的因数
%采样caiyang_fs需要时n的倍数
%N每bit采样个数
%测试数据
% jiance(2,40,10,2000,1,2)
%t=2;                       %运行时间
%bps=40;                    %数据速率
%A=10;                      %信号幅值
%fs=2000;                   %生成信号每秒点数
%fangcha=1;                 %方差
%N=2;                       %N次采样时
             
bitnum=bps*t;                      %数据长度
n=fs/bps;                     %每bit产生点
yuan=[];
num=t*fs;                   %总采样个数
outputp=[];                 %判决结果
H1=0;                       %1出现次数
H0=0;                       %0出现次数
c00=0;
c01=1;
c10=1;
c11=0;

% 生成数据
for i=1:bitnum              
    tmp=rand;
    if(tmp<0.5)
        b=zeros(1,n);
        H0=H0+1;
    else
        b=A*ones(1,n);
        H1=H1+1;
    end
    yuan=[yuan,b];
end

P1=H1/(H0+H1)
P0=H0/(H0+H1);

u=(P0*(c10-c00))/(P1*(c01-c11));
a=fangcha.*log(u)/(A*N) + A/2;

t1=0:1/fs:t-1/fs;
figure(1);
subplot(311);
plot(t1,yuan);    grid on;    title('原信号');  axis([0 t -2 A+1]);    legend('t=4')


s1=sqrt(fangcha).*randn(1,num)+yuan;   %加入方差为1/100，均值为0的高斯噪声

subplot(312);
plot(t1,s1);    grid on;    title('加噪信号 '); axis([0 t -2 A+1]);

jiange=n/N;

for i=1:bitnum
    tmp=0;
    for m=1:jiange:n
        tmp=tmp+s1( (i-1) * n + m );
    end
    tmp=tmp/N;
    if (tmp)<a
        s=zeros(1,n);
    else
        s=A*ones(1,n);
    end
    outputp=[outputp,s];
end       
subplot(313) 
plot(t1,outputp);   grid on;    axis([0 t -2 A+1]);   title('信号 ');
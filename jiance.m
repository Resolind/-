function a = jiance(t,bps,A,fs,fangcha,N)
%fs��Ҫ��bps�ı���
%����Ƶ���������ź��ٶȵ�����
%����caiyang_fs��Ҫʱn�ı���
%Nÿbit��������
%��������
% jiance(2,40,10,2000,1,2)
%t=2;                       %����ʱ��
%bps=40;                    %��������
%A=10;                      %�źŷ�ֵ
%fs=2000;                   %�����ź�ÿ�����
%fangcha=1;                 %����
%N=2;                       %N�β���ʱ
             
bitnum=bps*t;                      %���ݳ���
n=fs/bps;                     %ÿbit������
yuan=[];
num=t*fs;                   %�ܲ�������
outputp=[];                 %�о����
H1=0;                       %1���ִ���
H0=0;                       %0���ִ���
c00=0;
c01=1;
c10=1;
c11=0;

% ��������
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
plot(t1,yuan);    grid on;    title('ԭ�ź�');  axis([0 t -2 A+1]);    legend('t=4')


s1=sqrt(fangcha).*randn(1,num)+yuan;   %���뷽��Ϊ1/100����ֵΪ0�ĸ�˹����

subplot(312);
plot(t1,s1);    grid on;    title('�����ź� '); axis([0 t -2 A+1]);

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
plot(t1,outputp);   grid on;    axis([0 t -2 A+1]);   title('�ź� ');
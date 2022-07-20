
% -------------------------------------------------------------------------
%       LOADING THE INPUT WAVEFORM DATA IN SAF FORMAT
%--------------------------------------------------------------------------
clc;clear all
for fff=1:3
fileToRead1 = [num2str(fff) '.input' ];
textfilename=fileToRead1;
fid = fopen(textfilename,'r');
data=textscan(fid,'%f%f%f','delimiter','\t','headerlines', 12);
data{1};data{2};data{3};
DATA=[data{1} data{2} data{3}];
fclose(fid);
l=length(DATA(:,1));
z=DATA(:,1);%Vertical Component
%  High-pass filter used to filterout low frequency part of signal
[B, A]=butter(2,0.02,'high');% set to 1Hz value IT will make data like short period
z=filter(B,A,z);
z=z(201:l);% left 2 second data (distorted by filter effect)
z=z-mean(z);
%--------------------------------------------------------------------------
SR=100;%input('Enter the sampling rate, SR: ');
SP=1/SR; % Sampling Period
N=3000;%input('Coda-Wnindow');
Fs=100;%input('Enter the sampling Frequency, Fs: ')
NqF = Fs/2;
scrsz = get(0,'ScreenSize');% To assign the size of plotting window
%**************************************************************************
%
%**************************************************************************
figure ('position',[scrsz]);
plot(z);hold on
CT=ginput(2);hold off;close
Mpc=round(CT(1));
Msc=round(CT(2));
SS=round(Mpc-2.5*(Msc-Mpc));
if SS<1
    SS=1;
else
        SS=SS; 
end
SE=round((Msc+2.4*(Msc-Mpc))+1.5*N);
Lz=length(z);
if SE>Lz
    SE=Lz;
else
        SE=SE;
end
z=z(SS:SE);
QCDATA=z-mean(z);% Used for estimation of Qc
%--------------------------------------------------------------------------
%                   Plotting Data
%--------------------------------------------------------------------------
VX=QCDATA(:,1);
ln=length(VX);
t=(0:SP:(ln-1)*SP)';
tmin=0;tmax=max(t);
%--------------------------------------------------------------------------
%          GRAPHICAL INPUT FOR P and S-ONSETS
%--------------------------------------------------------------------------
figure ('position',[scrsz]);
plot(VX);title('Select P and S onsets');xlabel('time(samples)');
ylabel('Velocity(counts)');grid on;hold on
%--------------------------------------------------------------------------
PM=ginput(2);hold off;close
Mp=round(PM(1));
Ms=round(PM(2));
OT=Mp-(1.38*(Ms-Mp));
LT=2*(Ms-OT);
M=OT+LT;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
MX=max(abs(VX));
figure ('position',[scrsz]);
subplot(3,1,1);plot(VX);title('Vertical Component');
xlabel('time(samples)');ylabel('counts');axis([0 ln -MX MX])
grid on;hold on
lt=MX;ht=2*lt;
plot(OT,0,'or');plot(OT,0,'+b');%Plot of OT marking
  line([OT OT], [-lt ht],'LineStyle','--','Color','k');  % Origin time line
  tx=OT;
  ty=MX+0.2*MX;
  text(tx,ty,['Origion Time'],'HorizontalAlignment','center','EdgeColor','k'); 
%  
  line([Mp Mp], [-lt ht],'LineStyle','--','Color','r');% Picked P arrival
  tx=Mp;
  ty=MX+0.2*MX;
  text(tx,ty,['P-arrival'],'HorizontalAlignment','center','EdgeColor','r'); 
%  
  line([Ms Ms], [-lt ht],'LineStyle','--','Color','m');% Picked S arrival
  tx=Ms;
  ty=MX+0.2*MX;
  text(tx,ty,['S-arrival'],'HorizontalAlignment','center','EdgeColor','m'); 
% -------------------------------------------------------------------------
saveas(gcf,['PlotTH4Qc' num2str(fff)],'fig');
saveas(gcf,['plotTH4Qc' num2str(fff)],'bmp');hold off;close
%--------------------------------------------------------------------------
%                        Filtering the data
%--------------------------------------------------------------------------
data=VX;
fc=[1.50;3.00;6.00;9.00;12.00];
fb=[1.00;2.00;4.00;6.00;8.00;12.00;16.00];
n=length(fc);
for i=1:n
fc(i); fb(i);
fout(i,1)=fc(i);
f1(i)=(fc(i)-0.5*fb(i))/NqF;
f2(i)=(fc(i)+0.5*fb(i))/NqF;
clear a b;
[b,a] = butter(4,[f1(i) f2(i)]);
%freqz(b,a,512,Fs);pause
X=data;
xln=length(X);
Y= filtfilt(b,a,X); 
%-----------------------    SNR Estimation   ------------------------------
NSNR=512;
w=kaiser(NSNR);%     COSINE TAPER  (20%)tukeywin(N,0.2);%
wdata(:,1)=Y(Mp-NSNR:Mp-1,1).*w;
wdata(:,2)=Y(M:M+NSNR-1,1).*w;
n=NSNR/2;  
f=(1:n)*(SR/NSNR);
snrspec(:,1)=f;
for ik=1:2
    df=wdata(:,ik);
    b=fft(df);
    b=abs(b(1:n))./n;
    snrspec(:,ik+1)=b;
end
    rmsnoise=rms(snrspec(:,2));
    rmscoda=rms(snrspec(:,3));
    SNRc(i,1)=rmscoda/rmsnoise;

%--------------------------------------------------------------------------
%             Correction for geometrical spreading
%--------------------------------------------------------------------------
XY=Y(M+1:M+N,1);
%--------------------------------------------------------------------------
 XY=movavg(abs(XY),3,10,1);
 %--------------------------------------------------------------------------
yln=length(XY);
for kk=0:yln-1
    WT(kk+1)=((LT+kk)/100);% Lapse Time correction Vector
end
WY=XY.*WT';
%--------------------------------------------------------------------------
%           rms : sliding window of 1 second with stepping of 0.5 sec
%--------------------------------------------------------------------------
sp=200;% rms window length in samples
sph=0.5*sp-1;%window's stepping in samples
count = 0;
for dt=1:sp:N-sp+1
    count = count+1;
    k=dt+sph;
    nw=(k+0.5*sp)/100;
    wrms(count,1)=(LT+k)/100;
    amp=WY(dt:dt+sp-1,1);
    h(count,1)=sqrt(mean(amp.^2));
    wrms(count,2)=log(h(count,1));
end
%--------------------------------------------------------------------------
%                       MOVING AVERAGE 
%--------------------------------------------------------------------------
 xmov=movavg(wrms(:,2),2,3,1);
 wrms(2:length(xmov),2)=xmov(2:length(xmov));
%--------------------------------------------------------------------------
%           Plot (1) of filtered series showing coda part 
%                (2) lapse time vs rms
%--------------------------------------------------------------------------
mz=max(abs(Y));
figure ('position',[scrsz]);
subplot(2,1,1);plot(Y);
grid on;hold on;
axis([0 xln -mz mz]); 
rectangle('Position', [M -lt N ht],'FaceColor','y'...
                ,'EdgeColor','red','LineWidth',2,'LineStyle','-.');
            
 plot(M+1:M+N,Y(M+1:M+N),'r');
 line([OT OT], [-lt ht],'LineStyle','--','Color','k');  % Origin time line
 line([Mp Mp], [-lt ht],'LineStyle','--','Color','r');  % P arrival
 line([Ms Ms], [-lt ht],'LineStyle','--','Color','m');% S arrival
 plot(OT,0,'or');%Plot of OT
title(['Frequency Band =(',num2str(f1(i)*NqF),'Hz -',num2str(f2(i)*NqF),...
     'Hz);  SNR = ',num2str(SNRc(i,1),'%5.1f')],'FontSize',10);
 xlabel('Samples');ylabel('Amplitude(counts)');
 

 subplot(2,1,2);plot(wrms(:,1),wrms(:,2),'.b','markerfacecolor','b','markersize',25); grid off; hold on

   xlabel('Time (s)');ylabel('Amplitude(counts)');
    SL=polyfit(wrms(:,1),wrms(:,2),1);
    Q(i)=-pi*fc(i)./SL(1);
    rmscal=wrms(:,1)*SL(1)+SL(2);
    xcorr(i,1)=corr(wrms(:,2),rmscal);
    
%  -----------           SAVING RESULTS                  -----------------
    allQ(i,1)=fc(i);
    allQ(i,2)=Q(i);
    allQ(i,3)=xcorr(i);
    allQ(i,4)=SNRc(i);
%--------------------------------------------------------------------------
fln = [ 'allQ',num2str(fff) '.txt' ];
dlmwrite(fln,[allQ],'delimiter','\t','precision',6);  
%  ------------------------------------------------------------------------
    
    x1=wrms(1,1);
    x2=wrms(count,1);y1=SL(1)*x1+SL(2);y2=SL(1)*x2+SL(2);
    x=[x1 x2];y=[y1 y2];
    plot(x,y,'LineWidth',1);
  title(['Q = ',num2str(Q(i),'%5.1f'),';  Correlation =',num2str(xcorr(i,1),'%3.2f')],'FontSize',10);
% -------------------------------------------------------------------------
    saveas(gcf,['PlotRMS' num2str(fff*100+i)],'fig');
    saveas(gcf,['plotRMS' num2str(fff*100+i)],'bmp');hold off;close
% -------------------------------------------------------------------------
end
% -------------------------------------------------------------------------
%                   Selecting Values with Correlation > 0.5
% -------------------------------------------------------------------------
m=length(fc);

j=1;
c=0.5;% correlation above 70%
s=1 ; % SNR above 3
for k=1:m
if(Q(k)>10 && xcorr(k)>c && SNRc(k)>s)
    fcs(j)=fc(k);
    Qs(j)=Q(k);
    xcorrs(j)=xcorr(k);
    SNRcs(j)=SNRc(k);
    j=j+1;
end
end
%
szfcs=size(fcs);
if szfcs(1)<szfcs(2)
fcs=fcs';
else fcs=fcs;
end
%    
szQs=size(Qs);
if szQs(1)<szQs(2)
Qs=Qs';
else Qs=Qs;
end
%
szxcorrs=size(xcorrs);
if szxcorrs(1)<szxcorrs(2)
xcorrs=xcorrs';
else xcorrs=xcorrs;
end
%
szSNRcs=size(SNRcs);
if szSNRcs(1)<szSNRcs(2)
SNRcs=SNRcs';
else SNRcs=SNRcs;
end
%                     SAVING Qc Results
%--------------------------------------------------------------------------
finalout(:,1)=fcs;   finalout(:,2)=Qs; finalout(:,3)=xcorrs;finalout(:,4)=SNRcs;
fln = [ 'RESULTSQc',num2str(fff) '.txt' ];
dlmwrite(fln,[finalout],'delimiter','\t','precision',6);
%--------------------------------------------------------------------------
% Plotting and fitting of f vs Q to estimate freq. dependent Q
%--------------------------------------------------------------------------
    figure ('position',[scrsz]);
    plot(fcs,Qs,'*k');hold on
    plot(fcs,Qs,'or');
    xlabel('Frequency');ylabel('Q');
    ft = fittype( 'c*x.^d', 'independent', 'x', 'dependent', 'y' );
    fit4 = fit(fcs,Qs,ft);
    coefval=coeffvalues(fit4);
    qmvalues=coefval(1,1)*fcs.^coefval(1,2);
    qmcorr=corr(Qs,qmvalues);
   plot(fit4);xlabel('Frequency');ylabel('Qc');xlim ([0.8*min(fcs) 1.05*max(fcs)]);ylim([0 1.2*max(Qs)]);
   set(legend,'Location','SouthEast');
   xc=confint(fit4,0.85);
   qstd=coefval(1,1)-xc(1,1);
   fqstd=coefval(1,2)-xc(1,2);
%       e = std(Q)*ones(size(fc));
       e = 0.5*(qstd*fcs.^coefval(1,2));
     errorbar(fcs,Qs,e,'xk');
   txtqmx=min(fcs);
   txtqmy=max(Qs);
   text(txtqmx,1.12*txtqmy,['Q_c =',num2str(coefval(1,1),'%5.1f'),'\pm',num2str(qstd,'%3.1f'),'{\it f}^',...
       num2str(coefval(1,2),'{%5.2f}^'),'\pm^',num2str(fqstd,'{%3.2f}'),...
       '; Model Correlation =',num2str(qmcorr,'%5.2f')],'HorizontalAlignment','left',...
       'BackgroundColor',[1 1 .9],'EdgeColor','r',...
        'LineWidth',1,'FontSize',16);
  
% -------------------------------------------------------------------------
    saveas(gcf,['QcModel' num2str(fff)],'fig');
    saveas(gcf,['QcModel' num2str(fff)],'bmp');hold off;close
%--------------------------------------------------------------------------
%                     SAVING Qc Results
%--------------------------------------------------------------------------
fln = [ 'RMSwindow',num2str(fff) '.txt' ];
dlmwrite(fln,[wrms],'delimiter','\t','precision',6);
%--------------------------------------------------------------------------
%    fc     Q     n     stdQ      stdn         correlation
% -------------------------------------------------------------------------
load Qcresults.txt;
Qcresults(fff,1)=fff;
Qcresults(fff,2)=coefval(1,1);
Qcresults(fff,3)=coefval(1,2);
Qcresults(fff,4)=qstd;
Qcresults(fff,5)=fqstd;
Qcresults(fff,6)=qmcorr;
save Qcresults.txt  Qcresults* -ascii;clc;clear all
end
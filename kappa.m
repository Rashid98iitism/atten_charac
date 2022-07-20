%% CODE FOR KAPPA(SPECTRAL DEACY PARAMETER) MODEL ESTIMATION 
% Ref: using classical method by Anderson and Hough (1984)
%  BY RASHID SHAMS (5-06-2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%       accn_g=accleration values in g
%       Time_s=time values in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot accn_time history
g = 9.81;
acc= (accn_g*g).*100; %convert to cm/s^2
plot(Time_s,acc,'b');

%% Auto-S wave picking 
A=acc.*100; % cm/s2 to m/s2
dt = Time_s(2)-Time_s(1);
g=9.81;

% S wave onset time (ti)
aint2 = cumsum(A.^2)*pi*dt/(2*g);
arias = aint2(end);
cum_energy = aint2/arias;
e_temp=0.05;   % to find time (ti) corrpd to 5% energy
[v,idx]=min(abs(cum_energy-e_temp));
ti=Time_s(idx);                 % value of onset time of S wave

% S wave end time (tf)
rms_cum=((sqrt(cumtrapz(Time_s,accn_g.^2))./Time_s));    % seismic cumulative RMS of ground motion acceleration
sm=sgolayfilt(rms_cum(2:end),9,1001);            % smoothing function 
plot(Time_s(2:end),sm,'.');

% Find the tf value by observing the plot of time vs sm where tf occurs
% when there is a steady decrease in rms function 

fprintf('The value of S wave onset time (ti) for the event is %3.4d seconds\n',ti);

% s wave time window data 
tf=input('Enter the s wave end time tf obsv from the rms plot');
t_s=Time_s(find(Time_s==ti):find(Time_s==tf));
acc_s=acc(find(Time_s==ti):find(Time_s==tf));


%% Manual S wave picker
t1=input('Enter start time of S-wave');
t2=input('Enter end time of S-wave');

t_s=Time_s(find(Time_s==t1):find(Time_s==t2));
acc_s=acc(find(Time_s==t1):find(Time_s==t2));

% Combined plot of full vertical sesimogram and only S wave phase in it
plot(Time_s,acc,'b',t_s,acc_s,'k');
xlabel('Time(s)');ylabel('Acceleration(cm/s^2)');

%% Fourier accleration spectrum of S-wave phase picked out

dt = t_s(2)-t_s(1);
n = length(acc_s);         
Fs = 1/dt;                       % Sampling Frequency
NFFT = 2^nextpow2(n);            % Next power of 2 from length of data
Y = fft(acc_s,NFFT)/n;
f = Fs/2*linspace(0,1,NFFT/2+1);
Iv = 1:length(f);
U=abs(Y(Iv));

plot(f,U,'b');
set(gca, 'YScale', 'log');

%% Finding fe and fx frequencies in FAS
f1=input('Enter the frequency at the start of linear downward trend in FAS'); % f1 and f2 by observation only
f2=input('Enter thre frequency at the end of linear downward trend in FAS');

[~,idx]=min(abs(f-f1));
fe=f(idx);
[val,idx]=min(abs(f-f2));
fx=f(idx);


x=f(find(f==fe):find(f==fx));
y=U(find(f==fe):find(f==fx));
y=y';
semilogy(x,y,'b');

%% Best Fit line on the FAS 

logy = log(y);
coef_fit = polyfit(x,logy,1);
loglife_fit = polyval(coef_fit,x);
semilogy(x,y,'b');
hold on;
semilogy(x,exp(loglife_fit),'k','linewidth',2);


%% Best fit line on the full FAS
semilogy(f,U,'b');
hold on;
semilogy(x,exp(loglife_fit),'k','linewidth',2);
xlabel('Frequency (Hz)'); ylabel('Fourier Amplitude Spectrum');
text(15,10,'fe=4.10 Hz and fx=23.14 Hz');
set(gcf,'color','w');

% kappa (k) value for the event from the slope of the best-fit line 
k=abs(coef_fit(1)./pi);
fprintf('The value of Kappa for the event is %3.4d \n',k);

%% PLOTS

% S wave time window plots 
figure;
t=tiledlayout(4,1) % Requires R2019b or later
ax1=nexttile;
plot(ax1,Time_s,acc,'b','linewidth',1); ylabel('Acc(cm/s^2)');
ax2=nexttile;
plot(ax2,Time_s,acc,'b',t_s,acc_s,'k','linewidth',1);ylabel('Acc(cm/s^2)');legend('Acc-Time history','S-wave');
ax3=nexttile;
plot(ax3,Time_s,cum_energy,'b',ti,0.05,'ro');xline(ti,'--k','linewidth',1);ylabel('Cumulative Energy');
ax4=nexttile;
plot(ax4,Time_s(2:end),sm,'b');xline(tf,'--k','linewidth',1);ylabel('Cumulative RMS(cm/s^2)^2');

linkaxes([ax1,ax2,ax3,ax4],'x');
xlabel(t,'Time(s)');
set(gcf,'color','w');
xlim([0 500]);

% Kappa best fit line
figure;
semilogy(f,U,'b');
hold on;
semilogy(x,exp(loglife_fit),'k','linewidth',2);
xlabel('Frequency (Hz)'); ylabel('Fourier Amplitude Spectrum');hold on;
xline(f1,'--k','linewidth',2);hold on; xline(f2,'--k','linewidth',2);
legend('S-wave Spectra');
set(gcf,'color','w');

%% Smoothened FFT
 U_SM=sgolayfilt(U,9,21);
 semilogy(f,U_SM,'b');
 hold on;
 semilogy(x,exp(loglife_fit),'k','linewidth',2);hold on;
 xlabel('Frequency (Hz)'); ylabel('Fourier Amplitude Spectrum');
 xline(f1,'--k','linewidth',2);hold on; xline(f2,'--k','linewidth',2);
 xlim([0 50]);
legend('S-wave Spectra');
set(gcf,'color','w');
 
%% t significant calculation (90% ground motion duration)| Duration model 

A=acc.*100; % cm/s2 to m/s2
dt = Time_s(2)-Time_s(1);
g=9.81;

% 5 and 95 % arias intensity 
aint2 = cumsum(A.^2)*pi*dt/(2*g);
arias = aint2(end);
cum_energy = aint2/arias;
e1_temp=0.05;   % to find time (t_5) corrpd to 5% energy
e2_temp=0.95;   % tp find time (t_95) corrpd to 95% energy
[v1,idx1]=min(abs(cum_energy-e1_temp));
[v2,idx2]=min(abs(cum_energy-e2_temp));
t_5=Time_s(idx1);   
t_95=Time_s(idx2);

t_sig=t_95-t_5;

%% KAPPA MODEL PLOTS

subplot(3, 4, [1 2])
err1=repelem(0.00304,46);
errorbar(R_ism,k_v_ism,err1,'both','.b','markerfacecolor','b','markersize',15);hold on;
plot(R_ism,0.00004.*R_ism+0.0314,'k');
xlabel('Epicentral Distance(Km)','fontweight','bold','fontsize',10);ylabel('Kappa value','fontweight','bold','fontsize',10);text(500,0.06,'K_v=4E-05R+0.0314');
%title('(a)For N-S component');

subplot(3, 4, [3 4])
err2=repelem(0.00302,26);
errorbar(R_sbg,k_v_sbg,err2,'both','.b','markerfacecolor','b','markersize',15);hold on; 
plot(R_sbg,0.00002.*R_sbg+0.03,'k');text(500,0.06,'K_v=2E-05R+0.03');
xlabel('Epicentral Distance(Km)','fontweight','bold','fontsize',10);
%title('(b)For E-W component');

subplot(3, 4, [5 6])
err3=repelem(0.00206,22);
errorbar(R_knti,k_v_knti,err3,'both','.b','markerfacecolor','b','markersize',15);hold on;
plot(R_knti,0.00001.*R_knti+0.042,'k');text(500,0.06,'K_v=1E-05R+0.042');
xlabel('Epicentral Distance(Km)','fontweight','bold','fontsize',10);ylabel('Kappa value','fontweight','bold','fontsize',10);
%title('(c)For Verticcal component');

subplot(3, 4, [7 8])
err4=repelem(0.00206,17);
errorbar(R_nrs,k_v_nrs,err4,'both','.b','markerfacecolor','b','markersize',15);hold on;
plot(R_nrs,0.00002.*R_nrs+0.0335,'k');text(500,0.06,'K_v=2E-05R+0.0335');
xlabel('Epicentral Distance(Km)','fontweight','bold','fontsize',10);
%title('(c)For Verticcal component');

subplot(3, 4, [9 10])
err5=repelem(0.00206,14);
errorbar(R_bok,k_ns_bok,err5,'both','.b','markerfacecolor','b','markersize',15);hold on;
plot(R_bok,0.00001.*R_bok+0.0354,'k');text(500,0.06,'K_v=1E-05R+0.0335');
xlabel('Epicentral Distance(Km)','fontweight','bold','fontsize',10);ylabel('Kappa value','fontweight','bold','fontsize',10);
%title('(c)For Verticcal component');

subplot(3, 4, [11 12])
err6=repelem(0.00206,30);
errorbar(R_ptwr,k_v_ptwr,err6,'both','.b','markerfacecolor','b','markersize',15);hold on;
plot(R_ptwr,0.00002.*R_ptwr+0.0347,'k');text(500,0.06,'K_v=2E-05R+0.0347');
xlabel('Epicentral Distance(Km)','fontweight','bold','fontsize',10);
%title('(c)For Verticcal component');


set(gcf,'color','w');

%% Stress drop, source raduis and seismic moment 

m0=10.^(1.5*(mw+10.7));
r=(2.34*(3.5*100000)./(2*pi.*f))/100;

sd=(7*m0)./(16*(r*100).^3)*0.000001;

%%

subplot(3,4,[1 2])
plot(m_ism,k_v_ism,'.r','markerfacecolor','r','markersize',20);
xlabel('Magnitude');ylabel('Kappa');

subplot(3,4,[3 4])
plot(m_sbg,k_v_sbg,'.r','markerfacecolor','r','markersize',20);
xlabel('Magnitude');

subplot(3,4,[5 6])
plot(m_knti,k_v_knti,'.r','markerfacecolor','r','markersize',20);
xlabel('Magnitude');ylabel('Kappa');

subplot(3,4,[7 8])
plot(m_nrs,k_v_nrs,'.r','markerfacecolor','r','markersize',20);
xlabel('Magnitude');

subplot(3,4,[9 10])
plot(m_bok,k_v_bok,'.r','markerfacecolor','r','markersize',20);
xlabel('Magnitude');ylabel('Kappa');

subplot(3,4,[11 12])
plot(m_ptwr,k_v_ptwr,'.r','markerfacecolor','r','markersize',20);
xlabel('Magnitude');

set(gcf,'color','w');

%% Simulation Results 

subplot(2,2,[1 2])
plot(t_5,acc_5_150,'b','linewidth',1.5);
ylabel('Acceleration(cm/s^2)');

subplot(2,2,[3 4])
plot(t_5,acc_5_50,'b','linewidth',1.5);
ylabel('Acceleration(cm/s^2)');xlabel('Time(sec)');
set(gcf,'color','w');



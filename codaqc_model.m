% CODA-Qc MODEL 
% Using Single backscattering model and derived results
% 1. QC MODEL 2. EXTICTION DISTANCE (Le) 3. ANELASTIC ATTENUATION (gamma)
% 4. GROUND ACC. (A/A0)  5. COMPARISON OF 1/Q TO 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS-:f,qc

% OUTPUTS-:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% by RASHID SHAMS (JUNE-2021), IIT(ISM)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Qc MODEL 
f=[1.5 3 6 9 12]';

% for ISM STN
% LAPSE TIME=40 SEC
q_ism40=[338.226 553.274 1202.83 1810.33 2100]';
q_ism50=[456.17 582.55 1359.67 2002.23 2216.34]';
q_ism60=[502.12 682.44 1497.65 2186.74 2333.75]';
% Power-law fit Qc=Qo*f^(n)
y_ism40=221.95.*f.^(0.9239);
y_ism50=289.23.*f.^(0.8366);
y_ism60=332.71.*f.^(0.8104);
% plot
f1=figure;
plot(f,y_ism40,'k','linewidth',1);hold on;
plot(f,q_ism40,'db','markerfacecolor','b');text(2,1800,'Coda window=40 sec');
title('IIT(ISM) STN');text(2,1600,'Qc=221.95f^{0.9239}');
xlabel('Frequency(Hz)');ylabel('Qc');set(gcf,'color','w');
f2=figure;
plot(f,y_ism50,'k','linewidth',1);hold on;
plot(f,q_ism50,'dr','markerfacecolor','r');text(2,1800,'Coda window=50 sec');
title('IIT(ISM) STN');text(2,1600,'Qc=289.23f^{0.8366}');
xlabel('Frequency(Hz)');ylabel('Qc');set(gcf,'color','w');
f3=figure;
plot(f,y_ism60,'k','linewidth',1);hold on;
plot(f,q_ism60,'dk','markerfacecolor','k');text(2,1800,'Coda window=60 sec');
title('IIT(ISM) STN');text(2,1600,'Qc=332.71f^{0.8104}');
xlabel('Frequency(Hz)');ylabel('Qc');
set(gcf,'color','w');

% for SBG stn
q_sbg40=[343.486 544.101 900.34 1512.23 1957.419]';
q_sbg50=[394.22 612.83 1111.78 1783.77 2028.56]';
q_sbg60=[475.35 752.41 1232.11 1864.25 2147.10]'; 
% Power-law fit Qc=Qo*f^(n)
y_sbg40=227.48.*f.^(0.8406);
y_sbg50=267.47.*f.^(0.8229);
y_sbg60=342.19.*f.^(0.7432);
% plot
f4=figure;
plot(f,y_sbg40,'k','linewidth',1);hold on;
plot(f,q_sbg40,'db','markerfacecolor','b');text(2,1800,'Coda window=40 sec');
title('SBG STN');text(2,1600,'Qc=227.48f^{0.8406}');
xlabel('Frequency(Hz)');ylabel('Qc');set(gcf,'color','w');
f5=figure;
plot(f,y_sbg50,'k','linewidth',1);hold on;
plot(f,q_sbg50,'dr','markerfacecolor','r');text(2,1800,'Coda window=50 sec');
title('SBG STN');text(2,1600,'Qc=267.47f^{0.8229}');
xlabel('Frequency(Hz)');ylabel('Qc');set(gcf,'color','w');
f6=figure;
plot(f,y_sbg60,'k','linewidth',1);hold on;
plot(f,q_sbg60,'dk','markerfacecolor','k');text(2,1800,'Coda window=60 sec');
title('SBG STN');text(2,1600,'Qc=342.19f^{0.7432}');
xlabel('Frequency(Hz)');ylabel('Qc');set(gcf,'color','w');

% for knti stn
   q_knti40=[333.256 451.01 1209.698 1523.858 1852.565]';
   q_knti50=[386.148 489.365 1456.969 1873.655 2016.34]';
   q_knti60=[452.120 559.440 1597.653 1986.740 2233.750]';
% Power-law fit Qc=Qo*f^(n)
y_knti40=211.29.*f.^(0.8507);
y_knti50=240.61.*f.^(0.7878);
y_knti60=278.11.*f.^(0.7160);   

% for nrs stn
  q_nrs40=[379.335 586.23 1025 1612.23 2057.419]';
  q_nrs50=[458.569 612.83 1211.898 1783.77 2128.56]';
  q_nrs60=[497.998 752.41 1432.11 1864.25 2247.10]';
% Power-law fit Qc=Qo*f^(n)
y_nrs40=253.85.*f.^(0.8242);
y_nrs50=302.88.*f.^(0.7808);
y_nrs60=356.28.*f.^(0.7483);

% for bok stn
  q_bok40=[296.499 456.01 1100.698 1223.858 1652.565]';
  q_bok50=[376.495 519.365 1356.969 1489.655 1893.34]';
  q_bok60=[452.12 569.44 1537.653 1656.74 2059.75]';
% Power-law fit Qc=Qo*f^(n)
y_bok40=202.89.*f.^(0.8492);
y_bok50=252.95.*f.^(0.7951);
y_bok60=301.07.*f.^(0.7200);
  
% for PTWR stn
  q_ptwr40=[312.499 486.01 1200.698 1423.858 1852.565]';
  q_ptwr50=[356.495 572.365 1456.969 1589.655 2093.34]';
  q_ptwr60=[472.12 619.44 1537.653 1656.74 2359.75]';
% Power-law fit Qc=Qo*f^(n)
y_ptwr40=287.33.*f.^(0.8273);
y_ptwr50=333.29.*f.^(0.7679);
y_ptwr60=376.07.*f.^(0.7000);

%% Q mean model

for i=1:length(q_ism40)
    q_mean40(i)=(q_ism40(i)+q_sbg40(i)+q_knti40(i)+q_nrs40(i)+q_bok40(i)+q_ptwr40(i))./6;
    q_mean50(i)=(q_ism50(i)+q_sbg50(i)+q_knti50(i)+q_nrs50(i)+q_bok50(i)+q_ptwr50(i))./6;
    q_mean60(i)=(q_ism60(i)+q_sbg60(i)+q_knti60(i)+q_nrs60(i)+q_bok60(i)+q_ptwr60(i))./6;
    q_mean_all(i)=(q_mean40(i)+q_mean50(i)+q_mean60(i))./3;
end

plot(f,q_mean40,'dr','markerfacecolor','r');hold on;
plot(f,221.25.*f.^(0.8704),'r');hold on;
plot(f,q_mean50,'db','markerfacecolor','b');hold on;
plot(f,267.67.*f.^(0.8399),'b');hold on;
plot(f,q_mean60,'dm','markerfacecolor','m');hold on;
plot(f,324.22.*f.^(0.7892),'m');hold on;
plot(f,q_mean_all,'dk','markerfacecolor','k');hold on;
plot(f,281.09.*f.^(0.7980),'k');hold on;
legend('Coda-window=40sec','Q_c=221.25f^(^0^.^8^7^0^)','Coda-window=50sec','Q_c=267.67f^(^0^.^8^3^9^)','Coda-window=60sec','Q_c=324.22f^(^0^.^7^8^9^)','Mean Q_c Model','Q_c=281.09f^(^0^.^7^9^8^)','location','northwest','fontweight','bold','fontsize',10);
set(gcf,'color','w');
xlabel('Frequency(Hz)','fontweight','bold','fontsize',10);
ylabel('Q_c','fontweight','bold','fontsize',10);

%% Dependency of 'n' on lapse time
lt=[40 50 60];
n_ism=[0.8939 0.8366 0.8104];
n_sbg=[0.8406 0.8229 0.7432];
n_knti=[0.8907 0.8678 0.8560];
n_nrs=[0.8242 0.7808 0.7483];
n_bok=[0.8492 0.7951 0.7200];
n_ptwr=[0.8273 0.7679 0.7000];

plot(lt,n_ism,'-r^','markerfacecolor','r');hold on;
plot(lt,n_sbg,'-b^','markerfacecolor','b');hold on;
plot(lt,n_knti,'-g^','markerfacecolor','g');hold on;
plot(lt,n_nrs,'-m^','markerfacecolor','m');hold on;
plot(lt,n_bok,'-k^','markerfacecolor','k');hold on;
plot(lt,n_ptwr,'-y^','markerfacecolor','y');hold on;
legend('IIT(ISM)','SBG','KNTI','NRS','BOK','PTWR');
xlabel('Lapse Time(or Coda-window)');ylabel('n value');
xticks([40 50 60]);
xticklabels({'40','50','60'})
set(gcf,'color','w');

%% EXTINCTION DISTANCE 
v=3.5; % v is the shear wave velocity for cnp region

% FOR ism stn data
le_ism40=v.*flip(y_ism40)/(2*pi);
le_ism50=v.*flip(y_ism50)/(2*pi);
le_ism60=v.*flip(y_ism60)/(2*pi);
% Plot
f7=figure;
plot(f,le_ism40,'o-b','markerfacecolor','b');hold on;
plot(f,le_ism50,'o-r','markerfacecolor','r');hold on;
plot(f,le_ism60,'o-k','markerfacecolor','k');set(gcf,'color','w');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');
xlabel('Frequency(Hz)'); ylabel('Extinction Distance(Le)');


% for sbg stn data
le_sbg40=v.*flip(y_sbg40)/(2*pi);
le_sbg50=v.*flip(y_sbg50)/(2*pi);
le_sbg60=v.*flip(y_sbg60)/(2*pi);
% Plot
f8=figure;
plot(f,le_sbg40,'o-b','markerfacecolor','b');hold on;
plot(f,le_sbg50,'o-r','markerfacecolor','r');hold on;
plot(f,le_sbg60,'o-k','markerfacecolor','k');set(gcf,'color','w');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');
xlabel('Frequency(Hz)'); ylabel('Extinction Distance(Le)');


%% ANEALSTIC ATTENUATION 
v=3.5;
% for ism data
for i=1:length(f)
    gamma_ism40(i)=pi*f(i)*v/(y_ism40(i));
    gamma_ism50(i)=pi*f(i)*v/(y_ism50(i));
    gamma_ism60(i)=pi*f(i)*v/(y_ism60(i));
end

% for sbg data
for i=1:length(f)
    gamma_sbg40(i)=pi*f(i)*v/(y_sbg40(i));
    gamma_sbg50(i)=pi*f(i)*v/(y_sbg50(i));
    gamma_sbg60(i)=pi*f(i)*v/(y_sbg60(i));
end

tiledlayout(2,1);
ax1=nexttile;
plot(ax1,f,gamma_ism40,'s-r','markerfacecolor','r');hold on;
plot(ax1,f,gamma_ism50,'s-b','markerfacecolor','b');hold on;
plot(ax1,f,gamma_ism60,'s-m','markerfacecolor','m');set(gcf,'color','w');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s','location','northwest');
xlabel('Central Frequency(Hz)');ylabel('Anelastic Attenuation');

ax2=nexttile;
plot(ax2,f,gamma_sbg40,'s-r','markerfacecolor','r');hold on;
plot(ax2,f,gamma_sbg50,'s-b','markerfacecolor','b');hold on;
plot(ax2,f,gamma_sbg60,'s-m','markerfacecolor','m');set(gcf,'color','w');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s','location','northwest');
xlabel('Central Frequency(Hz)');ylabel('Anelastic Attenuation');

%% GROUND ACC.
v=3.5;
x=[10 30 50 70 100 200 300];

% for ism stn data
for i=1:length(x)
    alpha40(i)=pi*1/(221.95.*1.^(0.9239)*v);
    acc_ism40(i)=exp(-(alpha40(i)*x(i)));
    alpha50(i)=pi*1/(289.23.*1.^(0.8366)*v);
    acc_ism50(i)=exp(-(alpha50(i)*x(i)));
    alpha60(i)=pi*1/(332.71.*1.^(0.8104)*v);
    acc_ism60(i)=exp(-(alpha60(i)*x(i)));
end

% for sbg stn data

for i=1:length(x)
    alpha40(i)=pi*1/(227.48.*1.^(0.8406)*v);
    acc_sbg40(i)=exp(-(alpha40(i)*x(i)));
     alpha50(i)=pi*1/(267.47.*1.^(0.8229)*v);
    acc_sbg50(i)=exp(-(alpha50(i)*x(i)));
     alpha60(i)=pi*1/(342.19.*1.^(0.7432)*v);
    acc_sbg60(i)=exp(-(alpha60(i)*x(i)));
end

% for knti stn data

for i=1:length(x)
    alpha40(i)=pi*1/(211.29.*1.^(0.8907)*v);
    acc_knti40(i)=exp(-(alpha40(i)*x(i)));
     alpha50(i)=pi*1/(240.61.*1.^(0.8678)*v);
    acc_knti50(i)=exp(-(alpha50(i)*x(i)));
     alpha60(i)=pi*1/(278.11.*1.^(0.8560)*v);
    acc_knti60(i)=exp(-(alpha60(i)*x(i)));
end

% for nrs stn data

for i=1:length(x)
    alpha40(i)=pi*1/(253.85.*1.^(0.8242)*v);
    acc_nrs40(i)=exp(-(alpha40(i)*x(i)));
     alpha50(i)=pi*1/(302.88.*1.^(0.7808)*v);
    acc_nrs50(i)=exp(-(alpha50(i)*x(i)));
     alpha60(i)=pi*1/(356.28.*1.^(0.7483)*v);
    acc_nrs60(i)=exp(-(alpha60(i)*x(i)));
end

% for bok stn data

for i=1:length(x)
    alpha40(i)=pi*1/(202.89.*1.^(0.8492)*v);
    acc_bok40(i)=exp(-(alpha40(i)*x(i)));
     alpha50(i)=pi*1/(252.95.*1.^(0.7951)*v);
    acc_bok50(i)=exp(-(alpha50(i)*x(i)));
     alpha60(i)=pi*1/(301.07.*1.^(0.72)*v);
    acc_bok60(i)=exp(-(alpha60(i)*x(i)));
end

% for ptwr stn data

for i=1:length(x)
    alpha40(i)=pi*1/(287.33.*1.^(0.8273)*v);
    acc_ptwr40(i)=exp(-(alpha40(i)*x(i)));
     alpha50(i)=pi*1/(333.29.*1.^(0.7679)*v);
    acc_ptwr50(i)=exp(-(alpha50(i)*x(i)));
     alpha60(i)=pi*1/(376.07.*1.^(0.70)*v);
    acc_ptwr60(i)=exp(-(alpha60(i)*x(i)));
end

subplot(3, 4, [1 2])
plot(x,acc_ism40,'o-r','markerfacecolor','r');hold on;
plot(x,acc_ism50,'o-b','markerfacecolor','b');hold on;
plot(x,acc_ism60,'o-m','markerfacecolor','m');
set(gcf,'color','w');text(100,1,'IIT(ISM)');
xlabel('Distance (Km)');ylabel('A/A_o in g');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');

subplot(3, 4, [3 4])
plot(x,acc_sbg40,'o-r','markerfacecolor','r');hold on;
plot(x,acc_sbg50,'o-b','markerfacecolor','b');hold on;
plot(x,acc_sbg60,'o-m','markerfacecolor','m');
set(gcf,'color','w');text(100,1,'SBG');
xlabel('Distance (Km)');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');

subplot(3, 4, [5 6])
plot(x,acc_knti40,'o-r','markerfacecolor','r');hold on;
plot(x,acc_knti50,'o-b','markerfacecolor','b');hold on;
plot(x,acc_knti60,'o-m','markerfacecolor','m');
set(gcf,'color','w');text(100,1,'KNTI');
xlabel('Distance (Km)');ylabel('A/A_o in g');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');

subplot(3, 4, [7 8])
plot(x,acc_nrs40,'o-r','markerfacecolor','r');hold on;
plot(x,acc_nrs50,'o-b','markerfacecolor','b');hold on;
plot(x,acc_nrs60,'o-m','markerfacecolor','m');
set(gcf,'color','w');text(100,1,'NRS');
xlabel('Distance (Km)');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');

subplot(3, 4, [9 10])
plot(x,acc_bok40,'o-r','markerfacecolor','r');hold on;
plot(x,acc_bok50,'o-b','markerfacecolor','b');hold on;
plot(x,acc_bok60,'o-m','markerfacecolor','m');
set(gcf,'color','w');text(100,1,'BOK');
xlabel('Distance (Km)');ylabel('A/A_o in g');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');

subplot(3, 4, [11 12])
plot(x,acc_bok40,'o-r','markerfacecolor','r');hold on;
plot(x,acc_bok50,'o-b','markerfacecolor','b');hold on;
plot(x,acc_bok60,'o-m','markerfacecolor','m');
set(gcf,'color','w');text(100,1,'PTWR');
xlabel('Distance (Km)');
legend('Lapse time=40s','Lapse Time=50s','Lapse Time=60s');



%% calculation of A/A0 peak normalized amplitude at grid points

% Calculation of distance from stn to all grif points
v=3.8;
for i =1:length(lat)
    x(i)=deg2km(distance(lat(i),long(i),25.2381,87.6454));
end 
x=x';
% Calculation of A/A0 for each grid pt.

% for ism stn
%alpha40=pi*1/(221.95.*1.^(0.9239)*v);
%alpha50=pi*1/(289.23.*1.^(0.8366)*v);
%alpha60=pi*1/(332.71.*1.^(0.8104)*v);
% for sbg data
alpha40=pi*1/(227.48.*1.^(0.8406)*v);
alpha50=pi*1/(267.47.*1.^(0.8229)*v);
alpha60=pi*1/(342.19.*1.^(0.7432)*v);

for i=1:length(x)
    amp40(i)=exp(-(alpha40*x(i)));
    amp50(i)=exp(-(alpha50*x(i)));
    amp60(i)=exp(-(alpha60*x(i)));
end

%%

subplot(3, 4, [1 2])
plot(f,q_ism40,'dr','markerfacecolor','r'); hold on;
plot(f,y_ism40,'k');hold on;
plot(f,q_ism50,'db','markerfacecolor','b');hold on; 
plot(f,y_ism50,'k');hold on;
plot(f,q_sbg60,'dm','markerfacecolor','m'); hold on;
plot(f,y_sbg60,'k');
xlabel('Central Frequency(f_c)');ylabel('Q_c value');
legend('Coda Window=40s');

subplot(3, 4, [3 4])
plot(f,q_sbg40,'dr','markerfacecolor','r');hold on; 
plot(f,y_sbg40,'k');hold on;
plot(f,q_sbg50,'db','markerfacecolor','b');hold on; 
plot(f,y_sbg50,'k');hold on;
plot(f,q_sbg60,'dm','markerfacecolor','m'); hold on;
plot(f,y_sbg60,'k');
xlabel('Central Frequency(f_c)');legend('Coda Window=50s');

subplot(3, 4, [5 6])
plot(f,q_knti40,'dr','markerfacecolor','r'); hold on;
plot(f,y_knti40,'k');hold on;
plot(f,q_knti50,'db','markerfacecolor','b'); hold on;
plot(f,y_knti50,'k');hold on;
plot(f,q_knti60,'dm','markerfacecolor','m'); hold on;
plot(f,y_knti60,'k');hold on;
xlabel('Central Frequency(f_c)');ylabel('Q_c value');legend('Coda Window=60s');

subplot(3, 4, [7 8])
plot(f,q_nrs40,'dr','markerfacecolor','r'); hold on;
plot(f,y_nrs40,'k');hold on;
plot(f,q_nrs50,'db','markerfacecolor','b'); hold on;
plot(f,y_nrs50,'k');hold on;
plot(f,q_nrs60,'dm','markerfacecolor','m'); hold on;
plot(f,y_nrs60,'k');hold on;
xlabel('Central Frequency(f_c)');ylabel('Q_c value');legend('Coda Window=60s');

subplot(3, 4, [9 10])
plot(f,q_bok40,'dr','markerfacecolor','r'); hold on;
plot(f,y_bok40,'k');hold on;
plot(f,q_bok50,'db','markerfacecolor','b'); hold on;
plot(f,y_bok50,'k');hold on;
plot(f,q_bok60,'dm','markerfacecolor','m'); hold on;
plot(f,y_bok60,'k');hold on;
xlabel('Central Frequency(f_c)');ylabel('Q_c value');legend('Coda Window=60s');


subplot(3, 4, [11 12])
plot(f,q_ptwr40,'dr','markerfacecolor','r'); hold on;
plot(f,y_ptwr40,'k');hold on;
plot(f,q_ptwr50,'db','markerfacecolor','b'); hold on;
plot(f,y_ptwr50,'k');hold on;
plot(f,q_ptwr60,'dm','markerfacecolor','m'); hold on;
plot(f,y_ptwr60,'k');hold on;
xlabel('Central Frequency(f_c)');ylabel('Q_c value');legend('Coda Window=60s');

set(gcf,'color','w');
 
 %% comparison of Qc values
 f=[1.5,3,6,9,12];
 
 % INDIAN REGIONS
 % ECNP
 qc1=280.09.*f.^(0.80);
 % INDIAN SHIELD
 qc2=800.*f.^(0.42);
 %kachchh
 qc3=194.*f.^(0.9);
 % Jabalpur region
 qc4=339.*f.^(0.73);
 % northeast
 qc5=86.*f.^(1.02);
 %nw himalayas
 qc6=158.*f.^(1.05);
 % central india
 qc7=332.*f.^(0.59);
 
 % FOREIGN REGIONS
 % canadian shield
 qc8=900.*f.^(0.2);
 % Eastern canada
 qc9=1100.*f.^(0.19);
 % eastern us 
 qc10=800.*f.^(0.32);
 % central iran
 qc11=53.*f.^(1.02);
 % Dead sea
 qc12=65.*f.^(1.05);
 % Fruili,Italy
 qc13=80.*f.^(1.1);
 
 figure;
 plot(f,qc1,'-*k',f,qc2,'-kd',f,qc3,'-ys',f,qc4,'-+b',f,qc5,'-.+m',f,qc6,'-.*g',f,qc7,'-bd','linewidth',1);hold on;
 plot(f,qc8,'-+k',f,qc9,'-rd',f,qc10,'-gs',f,qc11,'-*b',f,qc12,'-+m',f,qc13,'-+c','linewidth',1);
% set(gca, 'YScale', 'log');
% set(gca, 'XScale', 'log');
 
 set(gcf,'color','w');
 
 h=legend('Present study','Indian Sheild(Singh et al.(2004))','Kachchh(Biswas et al.(2014)','Jabalpur Region(Singh et al.(1999)','North-East India(Gupta and Kumar(2002))','N-W Himalayas(Kumar et al. (2005))','Central India(Mandal et al. (2013))','Canadian Shield(Hasegawa (1985))','Eastern Canada(Chun et al. (1987))','Eastern U.S.(Gupta and McLaughin (1987))','Central Iran(Ma’hood et al. (2009))','Dead Sea(Van Eck (1988))','Fruili,Italy(Rovelli (1982))','Location','southoutside');
 xticks([1.5 3 6 9 12]);
 xticklabels({'1.5','3','6','9',12'});
 
 
%% CONTOUR PLOTs for Q variation with coda-window and central frequencies(fc)

lt=[40 50 60];
fc=[1.5 3 6 9 12];


% for iit(ism) stn
   q_ism40=[338.226 553.274 1202.83 1810.33 2100]';
   q_ism50=[456.17 582.55 1359.67 2002.23 2216.34]';
   q_ism60=[502.12 682.44 1497.65 2186.74 2333.75]';
   Z_ism=[q_ism40 q_ism50 q_ism60];

 % for sbg stn
   q_sbg40=[343.486 544.101 900.34 1512.23 1957.419]';
   q_sbg50=[394.22 612.83 1111.78 1783.77 2028.56]';
   q_sbg60=[475.35 752.41 1232.11 1864.25 2147.10]';
   Z_sbg=[q_sbg40 q_sbg50 q_sbg60];
   
% for knti stn
   q_knti40=[333.256 451.01 1209.698 1523.858 1852.565]';
   q_knti50=[386.148 489.365 1456.969 1873.655 2016.34]';
   q_knti60=[452.120 559.440 1597.653 1986.740 2233.750]';
   Z_knti=[q_knti40 q_knti50 q_knti60];

% for nrs stn
  q_nrs40=[379.335 586.23 1025 1612.23 2057.419]';
  q_nrs50=[458.569 612.83 1211.898 1783.77 2128.56]';
  q_nrs60=[497.998 752.41 1432.11 1864.25 2247.10]';
  Z_nrs=[q_nrs40 q_nrs50 q_nrs60];

% for bok stn
  q_bok40=[296.499 456.01 1100.698 1223.858 1652.565]';
  q_bok50=[376.495 519.365 1356.969 1489.655 1893.34]';
  q_bok60=[452.12 569.44 1537.653 1656.74 2059.75]';
  Z_bok=[q_bok40 q_bok50 q_bok60];
  
% for PTWR stn
  q_ptwr40=[312.499 486.01 1200.698 1423.858 1852.565]';
  q_ptwr50=[356.495 572.365 1456.969 1589.655 2093.34]';
  q_ptwr60=[472.12 619.44 1537.653 1656.74 2359.75]';
  Z_ptwr=[q_ptwr40 q_ptwr50 q_ptwr60];


   subplot(3, 4, [1 2])
   colormap(jet);
   contourf(lt,fc,Z_ism);
   xticks([40 50 60]);
   xticklabels({'40','50','60'})
   yticks([1.5 3 6 9 12]);
   yticklabels({'1.5','3','6','9','12'});
   xlabel('Coda-window(sec)');ylabel('f_c(Hz)');
   
   subplot(3, 4, [3 4])
   colormap(jet);
   contourf(lt,fc,Z_sbg);
   xticks([40 50 60]);
   xticklabels({'40','50','60'})
   yticks([1.5 3 6 9 12]);
   yticklabels({'1.5','3','6','9','12'});
   xlabel('Coda-window(sec)');
   
   subplot(3, 4, [5 6])
   colormap(jet);
   contourf(lt,fc,Z_knti);
   xticks([40 50 60]);
   xticklabels({'40','50','60'})
   yticks([1.5 3 6 9 12]);
   yticklabels({'1.5','3','6','9','12'});
   xlabel('Coda-window(sec)');ylabel('f_c(Hz)');
   
   subplot(3, 4, [7 8])
   colormap(jet);
   contourf(lt,fc,Z_nrs);
   xticks([40 50 60]);
   xticklabels({'40','50','60'})
   yticks([1.5 3 6 9 12]);
   yticklabels({'1.5','3','6','9','12'});
   xlabel('Coda-window(sec)')
   
   subplot(3, 4, [9 10])
   colormap(jet);
   contourf(lt,fc,Z_bok);
   xticks([40 50 60]);
   xticklabels({'40','50','60'})
   yticks([1.5 3 6 9 12]);
   yticklabels({'1.5','3','6','9','12'});
   xlabel('Coda-window(sec)');ylabel('f_c(Hz)');
   
   subplot(3, 4, [11 12])
   colormap(jet);
   contourf(lt,fc,Z_ptwr);
   xticks([40 50 60]);
   xticklabels({'40','50','60'})
   yticks([1.5 3 6 9 12]);
   yticklabels({'1.5','3','6','9','12'});
   xlabel('Coda-window(sec)');

   set(gcf,'color','w');




%%
f=[1.5 3 6 9 12];
le_ism40=[90.77 85.43 83.12 82.26 81.76];
le_ism50=[106.37 93.86 86.35 84.23 82.16];
le_ism60=[115.23 96.56 88.23 86.1 84.23];
le_sbg40=[87.77 84.43 82.32 81.16 80.26];
le_sbg50=[102.37 91.86 84.35 83.23 82.16];
le_sbg60=[112.23 92.56 86.23 85.1 82.23];
le_knti40=[97.77 88.43 85.12 82.26 79.76];
le_knti50=[105.37 91.86 87.35 83.23 81.16];
le_knti60=[111.23 95.56 89.23 84.1 82.23];
le_nrs40=[92.77 85.43 82.32 80.16 79.26];
le_nrs50=[98.37 89.86 85.35 82.23 81.16];
le_nrs60=[105.23 91.56 86.23 83.1 82.23];
le_bok40=[85.77 82.43 81.12 80.26 80.15];
le_bok50=[101.37 90.86 86.35 81.23 81.16];
le_bok60=[119.23 98.56 89.23 83.1 82.23];
le_ptwr40=[93.77 85.43 82.32 81.26 81.16];
le_ptwr50=[100.37 93.86 86.35 82.23 82.16];
le_ptwr60=[113.23 99.56 88.23 85.1 83.23];

subplot(3, 4, [1 2])
plot(f,le_ism40,'.-r','markerfacecolor','r','markersize',20); hold on;
plot(f,le_ism50,'.-b','markerfacecolor','b','markersize',20);hold on; 
plot(f,le_ism60,'.-m','markerfacecolor','m','markersize',20); hold on;
xlabel('f_c');ylabel('L_E');
legend('Coda Window=40s','Coda Window=50s','Coda Window=60s');

subplot(3, 4, [3 4])
plot(f,le_sbg40,'.-r','markerfacecolor','r','markersize',20);hold on; 
plot(f,le_sbg50,'.-b','markerfacecolor','b','markersize',20);hold on; 
plot(f,le_sbg60,'.-m','markerfacecolor','m','markersize',20); hold on;
xlabel('f_c');
legend('Coda Window=40s','Coda Window=50s','Coda Window=60s');

subplot(3, 4, [5 6])
plot(f,le_knti40,'.-r','markerfacecolor','r','markersize',20); hold on;
plot(f,le_knti50,'.-b','markerfacecolor','b','markersize',20); hold on;
plot(f,le_knti60,'.-m','markerfacecolor','m','markersize',20); hold on;
xlabel('f_c');ylabel('L_E');
legend('Coda Window=40s','Coda Window=50s','Coda Window=60s');

subplot(3, 4, [7 8])
plot(f,le_nrs40,'.-r','markerfacecolor','r','markersize',20); hold on;
plot(f,le_nrs50,'.-b','markerfacecolor','b','markersize',20); hold on;
plot(f,le_nrs60,'.-m','markerfacecolor','m','markersize',20); hold on;
xlabel('f_c');
legend('Coda Window=40s','Coda Window=50s','Coda Window=60s');

subplot(3, 4, [9 10])
plot(f,le_bok40,'.-r','markerfacecolor','r','markersize',20); hold on;
plot(f,le_bok50,'.-b','markerfacecolor','b','markersize',20); hold on;
plot(f,le_bok60,'.-m','markerfacecolor','m','markersize',20); hold on;
xlabel('f_c');ylabel('L_E');
legend('Coda Window=40s','Coda Window=50s','Coda Window=60s');

subplot(3, 4, [11 12])
plot(f,le_ptwr40,'.-r','markerfacecolor','r','markersize',20); hold on;
plot(f,le_ptwr50,'.-b','markerfacecolor','b','markersize',20); hold on;
plot(f,le_ptwr60,'.-m','markerfacecolor','m','markersize',20); hold on;
xlabel('f_c');
legend('Coda Window=40s','Coda Window=50s','Coda Window=60s');

set(gcf,'color','w');

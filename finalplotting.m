load('ECG_database.mat');
fs=1000;
d1=Org_Data1(2,:)/200;
d2=Org_Data2(2,:)/200;
d3=Org_Data3(2,:)/200;
noise_wn = wn/10;
noise_bwn = Org_bw_noise(1,1:5000)/200;
noise_emn = Org_em_noise(1,1:5000)/200;
noise_man = Org_ma_noise(1,1:5000)/200;
noise_pli = 0.1*sin(2*pi*60*(0:length(d1)-1)/fs);
x1=d1+noise_wn;
x2=d1+noise_bwn;
x3=d2+noise_emn;
x4=d1+noise_man;
x5=d1+noise_pli;
lamda = 1; %RLS
mu = 0.02; %LMS
a=0.1;  %NLMS
mu2 = 0.02; %for NLMS
M1 =2;%LMS
M2 =2;%NLMS
M3 =2;%RLS
% [e1,y1,w1] = myNLMS(x, noise,mu, M1, a);
% [e2,y2,w2] = myLMS(x, noise, mu2, M2);
% [e3,y3,w3] = myRLS(x,noise,lamda,M3);

%----for white noise---%
[e1_wn,y1_wn,w1_wn] = myLMS(x1,noise_wn, mu, M1);
[e2_wn,y2_wn,w2_wn] = myNLMS(x1, noise_wn, mu2, M2, a);
[e3_wn,y3_wn,w3_wn] = myRLS(x1,noise_wn,lamda, M3);
figure;
subplot(411); plot(x1); 
title('ECG corrupted by White Gaussian Noise');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(412); plot(e1_wn); 
title('LMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(413); plot(e2_wn); 
title('NLMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(414); plot(e3_wn); 
title('RLS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
figure;
plot(y1_wn'-noise_wn,'r'); hold on;
plot(y2_wn'-noise_wn,'b'); hold on;
plot(y3_wn'-noise_wn,'g'); hold on;
title('Error convergence curve of three algorithms for WN');
xlabel('Samples (n)');
ylabel('Error Magnitude');
legend('LMS','NLMS','RLS');
%-----for bwn---%
[e1_bwn,y1_bwn,w1_bwn] = myLMS(x2,noise_bwn, mu, M1);
[e2_bwn,y2_bwn,w2_bwn] = myNLMS(x2, noise_bwn, mu2, M2, a);
[e3_bwn,y3_bwn,w3_bwn] = myRLS(x2,noise_bwn,lamda, M3);
figure;
subplot(411); plot(x2); 
title('ECG corrupted by Baseline Wander Noise');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(412); plot(e1_bwn); 
title('LMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(413); plot(e2_bwn); 
title('NLMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(414); plot(e3_bwn); 
title('RLS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid

%-----for emn---%
[e1_emn,y1_emn,w1_emn] = myLMS(x3,noise_emn, mu, M1);
[e2_emn,y2_emn,w2_emn] = myNLMS(x3, noise_emn, mu2, M2, a);
[e3_emn,y3_emn,w3_emn] = myRLS(x3,noise_emn,lamda, M3);
figure;
subplot(411); plot(x3); 
title('ECG corrupted by Electrode Motion Artifact');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(412); plot(e1_emn); 
title('LMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(413); plot(e2_emn); 
title('NLMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(414); plot(e3_emn); 
title('RLS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
% figure;
% plot(y1_emn'-noise_emn,'r'); hold on;
% plot(y2_emn'-noise_emn,'b'); hold on;
% plot(y3_emn'-noise_emn,'g'); hold on;
% title('Error convergence curve of three algorithms for EMN');
% xlabel('Samples (n)');
% ylabel('Error Magnitude');
% legend('LMS','NLMS','RLS');
%----for man----%
[e1_man,y1_man,w1_man] = myLMS(x4,noise_man, mu, M1);
[e2_man,y2_man,w2_man] = myNLMS(x4, noise_man, mu2, M2, a);
[e3_man,y3_man,w3_man] = myRLS(x4,noise_man,lamda, M3);
figure;
subplot(411); plot(x4); 
title('ECG corrupted by Muscle Artifacts Noise');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(412); plot(e1_man); 
title('LMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(413); plot(e2_man); 
title('NLMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(414); plot(e3_man); 
title('RLS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid

%----for PLI----%
[e1_pli,y1_pli,w1_pli] = myLMS(x5,noise_pli, mu, M1);
[e2_pli,y2_pli,w2_pli] = myNLMS(x5, noise_pli, mu2, M2, a);
[e3_pli,y3_pli,w3_pli] = myRLS(x5,noise_pli,lamda, M3);
figure;
subplot(411); plot(x5); 
title('ECG corrupted by 60Hz PLI');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(412); plot(e1_pli); 
title('LMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(413); plot(e2_pli); 
title('NLMS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid
subplot(414); plot(e3_pli); 
title('RLS Filter Response');
xlabel('Samples (n)');
ylabel('Amplititude (mV)') ;grid

%--error--%
figure;
plot(y1_pli'-noise_pli,'r'); hold on;
plot(y2_pli'-noise_pli,'b'); hold on;
plot(y3_pli'-noise_pli,'g'); hold on;
title('Error convergence curve of three algorithms for 60Hz PLI');
xlabel('Samples (n)');
ylabel('Error Magnitude');
legend('LMS','NLMS','RLS');

figure;
plot(d1); 
title('Clean ECG signal (1)');
xlabel('Samples (n)');
ylabel('Amplititude (mV)');

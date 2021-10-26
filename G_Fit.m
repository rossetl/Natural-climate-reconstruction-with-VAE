%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    University of Padua, Department of Physics and Astronomy    %
%                      G(s) Reconstruction                       %
%                    Coded by: Andrea Zanola                     % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
tic

%---Dataset Description---
%Ringebu  is componsed by T_in and T_out (i.e DL1 and DL3) of the Ringebu
%                 Church from 2019-05-01 00:05:00 to 2019-09-01 00:00:00.
%E6Frya is the E6 Frya Dataset temperature time serie
load('Workspace_G_fit.mat')

%---Time Series Definition---
lt=length(Ringebu);
t=(0:5/60:(lt-1)*5/60)';
TIN(:,1)=t;
TIN(:,2)=Ringebu(:,1);
TOUT(:,1)=t;
TOUT(:,2)=Ringebu(:,2);

%---Grid Search Algorithm---
tau1v=[2.13];   
tau2v=[15.83];    
kstat=[1]; 
SCORE=zeros(length(tau1v), length(tau2v), length(kstat));
%Further studies shown that this is a suboptimal minimum:
%the new one is actually (6, 27.1, 1.0785)

for i=1:length(tau1v)
for j=1:length(tau2v)
for k=1:length(kstat)
    
    tau1=[tau1v(i) 1];      %Coefficients Vector Numerator G(s)
    tau2=[tau2v(j) 1];      %Coefficients Vector Denominator G(s)
    K=kstat(k);             %Kstat
    
    %---Simulink Interface---
    temp=sim('Tuning_Circuit',2952);
    set_param(gcs, 'SimulationCommand', 'stop')
    c=temp.error_out;
    SCORE(i,j,k)=sum(c);
end
end
end
set_param(gcs, 'SimulationCommand', 'stop');

a=min(min(min(SCORE)));
[r,c,z] = ind2sub(size(SCORE), find(SCORE == a));

%---Final Simulation with Best Parameters---
tau1=[tau1v(r) 1];
tau2=[tau2v(c) 1];
K=kstat(z);
temp=sim('Tuning_Circuit',2952);
set_param(gcs, 'SimulationCommand', 'stop');
disp(tau1v(r));
disp(tau2v(c));
disp(kstat(z));
disp(a);

%---Reconstruction of the new syntetic time serie---
lt_long= length(E6Frya);
t_long = (0:5/60:(lt_long-1)*5/60)';
Tstaz(:,1)= t_long;
Tstaz(:,2)= E6Frya;

temp1=sim('Reconstruction_Circuit',43848);
set_param(gcs, 'SimulationCommand', 'stop');

toc

%---Visualization---
subplot(3,1,1)  %Magnitude bode diagram
w=logspace(-3,2,1000);
mod=(((tau1v(r)*w).^2+1)./((tau2v(c)*w).^2+1)).^0.5;    
semilogx(w,mod,'linewidth',2), ylabel('Gain [ ]'), grid on;
ax = gca; ax.FontSize = 20; ax.LineWidth=1;

subplot(3,1,2)  %Phi(s) phade bode diagram
phi=atan(tau1v(r)*w)-atan(tau2v(c)*w);     
semilogx(w,phi,'linewidth',2), ylabel('Phase [rad]'), grid on;
ax = gca; ax.FontSize = 20; ax.LineWidth=1;

subplot(3,1,3)  %T_shift diagram
shift=phi./w;
semilogx(w,shift,'linewidth',2), ylabel('Temporal shift [h]'), xlabel('\omega [rad/h]');
grid on; ax = gca; ax.FontSize = 20; ax.LineWidth=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
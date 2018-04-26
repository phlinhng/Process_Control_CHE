function ch7
sel_method=startfun;
computefun(sel_method)
function computefun(sel_method)
if sel_method == 0
    t1=input('Input the value of t1(0.283dCs):');
    t2=input('Input the value of t2(0.632dCs):');
    [tau,t0]=fit33(t1,t2);
    fprintf('tau=%.3f, t0=%.3f\n',tau,t0)
    fprintf('Please restart this program and choice another function you want\n')
elseif sel_method == 1
    sel_pcon=pcontrolfun;
    [tau,t0,K]=taut0kfun;
    [Kc,tau_I,tau_D]=quart(sel_pcon,tau,t0,K);
    printresultfun(Kc,tau_I,tau_D)
elseif sel_method == 2
    sel_pcon=pcontrolfun;
    [tau,t0,K]=taut0kfun;
    [Kc,tau_I,tau_D]=miniiae_dis(sel_pcon,tau,t0,K);
    printresultfun(Kc,tau_I,tau_D)
elseif sel_method == 3
    sel_pcon=pcontrolfun;
    [tau,t0,K]=taut0kfun;
    [Kc,tau_I,tau_D]=miniiae_sp(sel_pcon,tau,t0,K);
    printresultfun(Kc,tau_I,tau_D)
elseif sel_method == 4
    sel_pcon=pcontrolfun;
    sel_pcon=3;
    fprintf('This module is for PID only. No selection needed.\n')
    fprintf('Notice: Sometimes you have to use t0_e=t0 + t0'' instead of just t0\n')
    [tau,t0,K]=taut0kfun;
    Kc=0.5/K*(t0/tau)^(-1);
    tau_I=input('tau_I=?');
    fprintf('Kc=%.3f (5%% Overshoot), tau_I=%.3f\n',Kc,tau_I)
    fprintf('Please restart this program and choice another function you want.\n')
elseif sel_method == 5
    Kc_prime=input('Kc_prime=?');
    tau_I_prime=input('tau_I_prime=?');
    tau_D_prime=input('tau_D_prime=?');
    [Kc,tau_I,tau_D]=pidconv(Kc_prime,tau_I_prime,tau_D_prime);
    printresultfun(Kc,tau_I,tau_D)
end

function sel_method=startfun
clear;
fprintf('Quick calculator for PC Ch7\n')
fit3=('0.FOPDT fit 3(use this first)');
quar=char('1.Quarter Decay Response');
minid=char('2.Minimum IAE for disturbance inputs');
minis=char('3.Minimum IAE for set point inputs');
cons=char('4.Controller Synthesis(Dahlin)');
pidtf=char('5.Convert actual PID to ideal PID');
fprintf('Choose a tuning method\n%s\n%s\n%s\n%s\n%s\n%s\n',fit3,quar,minid,minis,cons,pidtf)
sel_method=input('Your Choice:');

function sel_pcon=pcontrolfun
sel_pcon=input('1.Proportional 2.PI 3.PID(actual)?');

function [tau,t0,K]=taut0kfun
tau=input('tau=?');
t0=input('t0=?');
K=input('K=?');

function printresultfun(Kc,tau_I,tau_D)
fprintf('Kc=%.3f, tau_I=%.3f, tau_D=%.3f\n',Kc,tau_I,tau_D)
fprintf('Please restart this program and choice another function you want.\n')

function [tau,t0]=fit33(t1,t2)
tau=1.5*(t2-t1);
t0=t2 -tau;

function [Kc,tau_I,tau_D]=quart(sel_pcon,tau,t0,K)
Kc=0; tau_I=0; tau_D=0;
if sel_pcon == 1
    Kc=1/K*(t0/tau)^(-1);
elseif sel_pcon == 2
    Kc=0.9/K*(t0/tau)^(-1);
    tau_I=3.30*t0;
elseif sel_pcon == 3
    Kc=1.2/K*(t0/tau)^(-1);
    tau_I=2.0*t0;
    tau_D=t0/2;
end

function [Kc,tau_I,tau_D]=miniiae_dis(sel_pcon,tau,t0,K)
Kc=0; tau_I=0; tau_D=0;
if sel_pcon == 1
    Kc=0.902/K*(t0/tau)^(-0.985);
elseif sel_pcon == 2
    Kc=0.984/K*(t0/tau)^(-0.986);
    tau_I=tau/0.608*(t0/tau)^(0.707);
elseif sel_pcon == 3
    Kc=1.435/K*(t0/tau)^(-0.921);
    tau_I=tau/0.878*(t0/tau)^(0.749);
    tau_D=tau*0.482*(t0/tau)^(1.137);
end

function [Kc,tau_I,tau_D]=miniiae_sp(sel_pcon,tau,t0,K)
Kc=0; tau_I=0; tau_D=0;
if sel_pcon == 2
    Kc=0.758/K*(t0/tau)^(-0.861);
    tau_I=tau/(1.02-0.323*(t0/tau));
elseif sel_pcon == 3
    Kc=1.086/K*(t0/tau)^(-0.869);
    tau_I=tau/(0.740-0.130*(t0/tau));
    tau_D=0.348*tau*(t0/tau)^(0.914);
end

function [Kc,tau_I,tau_D]=pidconv(Kc_prime,tau_I_prime,tau_D_prime)
kc_=Kc_prime; taui_=tau_I_prime; taud_=tau_D_prime;
Kc = kc_*(1+taud_/taui_);
tau_I=taui_+taud_;
tau_D=taui_*taud_/(taui_+taud_);


    

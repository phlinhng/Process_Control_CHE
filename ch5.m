function ch5
sel_method=startfun;
computefun(sel_method)

function computefun(sel_method)
if sel_method == 1
    fprintf('----------------------------Liquid Service----------------------------\n')
    fprintf('Eqn: Cv = f*sqrt(Gf/dP0)\n')
    fprintf('f: flow through valve(gpm)\n')
    fprintf('Gf: specific gravity(molar mass of fluid/29)\n')
    fprintf('dP0: pressure drop for valve(psi)\n')
    f=input('flow=?');
    Gf=input('Gf=?');
    dP0=input('Pressure drop=?');
    ovcap=input('Overcapcity (in %)?');
    Cv=f*sqrt(Gf/dP0)*(1+ovcap/100);
    fprintf('Cv=%.3f for %d%% overcapacity\n',Cv,ovcap)
elseif sel_method == 2
    fprintf('----------------------------Liquid Service----------------------------\n')
    fprintf('Eqn: f = Cv_max / sqrt(1+kL*(Cv_max)^2) * sqrt(dP/Gf)\n')
    fprintf('Cv_max: maximum Cv (obtain by calculation or from given\n')
    fprintf('Gf: specific gravity(molar mass of fluid/29)\n')
    fprintf('dP0: pressure drop for valve(psi)\n')
    fprintf('kL = dPL / (Gf*fn^2)\n')
    fprintf('dPL: pressure drop in line(psi)\n')
    fprintf('fn: nominal oil flow(gpm)\n')
    fprintf('dP: total pressure drop(valve+line)(psi)\n')
    Cv_max=input('Cv_max=?');
    Gf=input('Gf=?');
    dP0=input('Pressure drop in valve=?');
    dPL=input('Pressure drop in line=?');
    fn=input('Nominal flow=?');
    kL = dPL / (Gf*fn^2);
    dP = dPL + dP0;
    f = Cv_max / sqrt(1+kL*(Cv_max)^2) * sqrt(dP/Gf);
    fprintf('f=%.3f\n',f)
elseif sel_method == 3
    fprintf('--------------------------Compressible  Flow--------------------------\n')
    fprintf('Eqn: fs = 836*Cv*Cf*p1/sqrt(G*T)*(y-0.148*y^3)\n')
    fprintf('fs: gas flow (scfh)\n')
    fprintf('G: specific gravity\n')
    fprintf('T: temp. at the valve inlet, degreeR = F + 460\n')
    fprintf('Cf: crtical flow factor\n')
    fprintf('p1: pressure at inlet valve(psia)')
    fprintf('Hint: psig + 14.7 = psia\n')
    fprintf('y = 1.63/Cf * sqrt(dPv/p1)\n')
    fprintf('dPv: p1-p2, pressure drop across the valve,psi\n')
    Cv=input('Cv=?');
    Cf=input('Cf=?');
    G=input('Specific gravity=?')
    T=input('T=? (USE DEGREE R)');
    p1=input('p1=?');
    dPv=input('Pressure drop across the valve=?');
    y = 1.63/Cf * sqrt(dPv/p1);
    fs = 836*Cv*Cf*p1/sqrt(G*T)*(y-0.148*y^3);
    fprintf('fs=%.3f\n',fs)
elseif sel_method == 4
    fprintf('fs_bar: nominal flow of stream in scfh\n')
    fs=input('fs_bar=?');
    Cf=input('Cf=?');
    G=input('Specific gravity=?');
    T=input('T=? (USE DEGREE R)');
    p1=input('p1=? (psi)');
    dPv=input('Pressure drop across the valve=?');
    y = 1.63/Cf * sqrt(dPv/p1);
    Cv = fs*sqrt(G*T)/(836*Cf*p1*(y-0.148*y^3));
    fprintf('Cv=%.3f\n',Cv)
elseif sel_method == 5
    fprintf('Linear valve: Cv=Cv_max*vp\n')
    fprintf('Equal percentage valve: Cv=Cv_max*alpha^(vp-1)\n')
    defaul=input('Use default?(Y/N)','s');
    if defaul == 'Y' | defaul == 'y'
        Cv_max=640;
        Gf=0.94;
        dP0=5;
        dPL=6;
        fn=700;
        alpha=50;
    else
        Cv_max=input('Cv_max=?');
        Gf=input('Gf=?');
        dP0=input('Pressure drop in valve=?');
        dPL=input('Pressure drop in line=?');
        fn=input('Nominal flow=?');
        alpha=input('alpha=?');
    end
    kL = dPL / (Gf*fn^2);
    dP = dPL + dP0;
    vp=linspace(0,1);
    for i=1:100
    f_l(i) = Cv_max * vp(i) / sqrt(1+kL*(Cv_max*vp(i))^2) * sqrt(dP/Gf);
    f_eq(i) = Cv_max * alpha^(vp(i)-1) / sqrt(1+kL*(Cv_max)^2*alpha^(vp(i)-1)^2) * sqrt(dP/Gf);
    end
    plot(vp,f_l,'-b',vp,f_eq,'-r')
    xlabel('vp');
    ylabel('Flow, f');
    legend('Linear','Equal Percentage')
elseif sel_method == 6
    fprintf('Hint: 1lbmole = 380scf\n');
    lbh=input('Value of lb/h: ');
    if isempty(lbh) == 1
        scfh=input('Value of scfh: ');
        ms=input('Value of Molar mass(lb/lbmole): ');
        lbh=scfh*ms/380;
        fprintf('%.3f scfh equals %.3f lb/h (molar mass=%d)\n',scfh,lbh,ms)
    else
        ms=input('Value of Molar mass(lb): ');
        scfh=lbh/ms*380;
        fprintf('%.3f lb/h equals %.3f scfh (molar mass = %d)\n',lbh,scfh,ms)
    end
end
function sel_method=startfun
clear;
fprintf('Quick calculator for PC Ch5\n')
mcv=char('1.Calculate Cv(Control Value) for given flow(gpm)');
mf=char('2.Calculate flow when the valve were fully opened');
fprintf('Choose a module to use\n')
fprintf('----------------------------Liquid Service----------------------------\n')
fprintf('%s\n%s\n',mcv,mf)
fprintf('--------------------------Compressible  Flow--------------------------\n')
mfs=('3.Calculate flow using Masoneilan Equation');
mccv=('4.Calculate Cv using Masoneilan Equation');
fprintf('%s\n%s\n',mfs,mccv)
fprintf('--------------------------Other useful tools--------------------------\n')
mra=('5.Install valve characteristics, f-vp plot');
mscfh=('6. scfh <=> lb/h Convertion');
fprintf('%s\n%s\n',mra,mscfh);
sel_method=input('Your Choice:');
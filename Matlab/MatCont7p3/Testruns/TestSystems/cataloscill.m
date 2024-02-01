function out = cataloscill
out{1} = @init;
out{2} = @fun_eval;
out{3} = @jacobian;
out{4} = @jacobianp;
out{5} = @hessians;
out{6} = @hessiansp;
out{7} = @der3;
out{8} = @der4;
out{9} = @der5;

% --------------------------------------------------------------------------
function dydt = fun_eval(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
z=1-kmrgd(1)-kmrgd(2)-kmrgd(3);
dydt=[2*par_q1*z^2-2*par_q5*kmrgd(1)^2-par_q3*kmrgd(1)*kmrgd(2);
par_q2*z-par_q6*kmrgd(2)-par_q3*kmrgd(1)*kmrgd(2);
par_q4*z-par_k*par_q4*kmrgd(3);];

% --------------------------------------------------------------------------
function [tspan,y0,options] = init
handles = feval(cataloscill);
y0=[0,0,0];
options = odeset('Jacobian',handles(3),'JacobianP',handles(4),'Hessians',handles(5),'HessiansP',handles(6));
tspan = [0 10];

% --------------------------------------------------------------------------
function jac = jacobian(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
jac=[ 2*par_q1*(2*kmrgd(3) + 2*kmrgd(1) + 2*kmrgd(2) - 2) - 4*kmrgd(1)*par_q5 - kmrgd(2)*par_q3 , 2*par_q1*(2*kmrgd(3) + 2*kmrgd(1) + 2*kmrgd(2) - 2) - kmrgd(1)*par_q3 , 2*par_q1*(2*kmrgd(3) + 2*kmrgd(1) + 2*kmrgd(2) - 2) ; - par_q2 - kmrgd(2)*par_q3 , - par_q2 - par_q6 - kmrgd(1)*par_q3 , -par_q2 ; -par_q4 , -par_q4 , - par_q4 - par_k*par_q4 ];
% --------------------------------------------------------------------------
function jacp = jacobianp(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
jacp=[ 2*(kmrgd(3) + kmrgd(1) + kmrgd(2) - 1)^2 , 0 , -kmrgd(1)*kmrgd(2) , 0 , -2*kmrgd(1)^2 , 0 , 0 ; 0 , 1 - kmrgd(1) - kmrgd(2) - kmrgd(3) , -kmrgd(1)*kmrgd(2) , 0 , 0 , -kmrgd(2) , 0 ; 0 , 0 , 0 , 1 - kmrgd(1) - kmrgd(2) - kmrgd(3)*par_k - kmrgd(3) , 0 , 0 , -kmrgd(3)*par_q4 ];
% --------------------------------------------------------------------------
function hess = hessians(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
hess1=[ 4*par_q1 - 4*par_q5 , 4*par_q1 - par_q3 , 4*par_q1 ; 0 , -par_q3 , 0 ; 0 , 0 , 0 ];
hess2=[ 4*par_q1 - par_q3 , 4*par_q1 , 4*par_q1 ; -par_q3 , 0 , 0 ; 0 , 0 , 0 ];
hess3=[ 4*par_q1 , 4*par_q1 , 4*par_q1 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
hess(:,:,1) =hess1;
hess(:,:,2) =hess2;
hess(:,:,3) =hess3;
% --------------------------------------------------------------------------
function hessp = hessiansp(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
hessp1=[ 4*kmrgd(3) + 4*kmrgd(1) + 4*kmrgd(2) - 4 , 4*kmrgd(3) + 4*kmrgd(1) + 4*kmrgd(2) - 4 , 4*kmrgd(3) + 4*kmrgd(1) + 4*kmrgd(2) - 4 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
hessp2=[ 0 , 0 , 0 ; -1 , -1 , -1 ; 0 , 0 , 0 ];
hessp3=[ -kmrgd(2) , -kmrgd(1) , 0 ; -kmrgd(2) , -kmrgd(1) , 0 ; 0 , 0 , 0 ];
hessp4=[ 0 , 0 , 0 ; 0 , 0 , 0 ; -1 , -1 , - par_k - 1 ];
hessp5=[ -4*kmrgd(1) , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
hessp6=[ 0 , 0 , 0 ; 0 , -1 , 0 ; 0 , 0 , 0 ];
hessp7=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , -par_q4 ];
hessp(:,:,1) =hessp1;
hessp(:,:,2) =hessp2;
hessp(:,:,3) =hessp3;
hessp(:,:,4) =hessp4;
hessp(:,:,5) =hessp5;
hessp(:,:,6) =hessp6;
hessp(:,:,7) =hessp7;
%---------------------------------------------------------------------------
function tens3  = der3(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
tens31=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens32=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens33=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens34=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens35=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens36=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens37=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens38=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens39=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens3(:,:,1,1) =tens31;
tens3(:,:,1,2) =tens32;
tens3(:,:,1,3) =tens33;
tens3(:,:,2,1) =tens34;
tens3(:,:,2,2) =tens35;
tens3(:,:,2,3) =tens36;
tens3(:,:,3,1) =tens37;
tens3(:,:,3,2) =tens38;
tens3(:,:,3,3) =tens39;
%---------------------------------------------------------------------------
function tens4  = der4(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
tens41=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens42=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens43=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens44=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens45=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens46=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens47=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens48=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens49=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens410=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens411=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens412=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens413=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens414=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens415=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens416=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens417=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens418=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens419=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens420=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens421=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens422=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens423=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens424=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens425=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens426=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens427=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens4(:,:,1,1,1) =tens41;
tens4(:,:,1,1,2) =tens42;
tens4(:,:,1,1,3) =tens43;
tens4(:,:,1,2,1) =tens44;
tens4(:,:,1,2,2) =tens45;
tens4(:,:,1,2,3) =tens46;
tens4(:,:,1,3,1) =tens47;
tens4(:,:,1,3,2) =tens48;
tens4(:,:,1,3,3) =tens49;
tens4(:,:,2,1,1) =tens410;
tens4(:,:,2,1,2) =tens411;
tens4(:,:,2,1,3) =tens412;
tens4(:,:,2,2,1) =tens413;
tens4(:,:,2,2,2) =tens414;
tens4(:,:,2,2,3) =tens415;
tens4(:,:,2,3,1) =tens416;
tens4(:,:,2,3,2) =tens417;
tens4(:,:,2,3,3) =tens418;
tens4(:,:,3,1,1) =tens419;
tens4(:,:,3,1,2) =tens420;
tens4(:,:,3,1,3) =tens421;
tens4(:,:,3,2,1) =tens422;
tens4(:,:,3,2,2) =tens423;
tens4(:,:,3,2,3) =tens424;
tens4(:,:,3,3,1) =tens425;
tens4(:,:,3,3,2) =tens426;
tens4(:,:,3,3,3) =tens427;
%---------------------------------------------------------------------------
function tens5  = der5(t,kmrgd,par_q1,par_q2,par_q3,par_q4,par_q5,par_q6,par_k)
tens51=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens52=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens53=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens54=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens55=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens56=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens57=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens58=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens59=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens510=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens511=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens512=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens513=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens514=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens515=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens516=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens517=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens518=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens519=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens520=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens521=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens522=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens523=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens524=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens525=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens526=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens527=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens528=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens529=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens530=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens531=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens532=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens533=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens534=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens535=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens536=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens537=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens538=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens539=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens540=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens541=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens542=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens543=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens544=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens545=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens546=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens547=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens548=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens549=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens550=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens551=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens552=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens553=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens554=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens555=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens556=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens557=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens558=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens559=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens560=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens561=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens562=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens563=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens564=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens565=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens566=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens567=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens568=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens569=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens570=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens571=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens572=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens573=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens574=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens575=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens576=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens577=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens578=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens579=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens580=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens581=[ 0 , 0 , 0 ; 0 , 0 , 0 ; 0 , 0 , 0 ];
tens5(:,:,1,1,1,1) =tens51;
tens5(:,:,1,1,1,2) =tens52;
tens5(:,:,1,1,1,3) =tens53;
tens5(:,:,1,1,2,1) =tens54;
tens5(:,:,1,1,2,2) =tens55;
tens5(:,:,1,1,2,3) =tens56;
tens5(:,:,1,1,3,1) =tens57;
tens5(:,:,1,1,3,2) =tens58;
tens5(:,:,1,1,3,3) =tens59;
tens5(:,:,1,2,1,1) =tens510;
tens5(:,:,1,2,1,2) =tens511;
tens5(:,:,1,2,1,3) =tens512;
tens5(:,:,1,2,2,1) =tens513;
tens5(:,:,1,2,2,2) =tens514;
tens5(:,:,1,2,2,3) =tens515;
tens5(:,:,1,2,3,1) =tens516;
tens5(:,:,1,2,3,2) =tens517;
tens5(:,:,1,2,3,3) =tens518;
tens5(:,:,1,3,1,1) =tens519;
tens5(:,:,1,3,1,2) =tens520;
tens5(:,:,1,3,1,3) =tens521;
tens5(:,:,1,3,2,1) =tens522;
tens5(:,:,1,3,2,2) =tens523;
tens5(:,:,1,3,2,3) =tens524;
tens5(:,:,1,3,3,1) =tens525;
tens5(:,:,1,3,3,2) =tens526;
tens5(:,:,1,3,3,3) =tens527;
tens5(:,:,2,1,1,1) =tens528;
tens5(:,:,2,1,1,2) =tens529;
tens5(:,:,2,1,1,3) =tens530;
tens5(:,:,2,1,2,1) =tens531;
tens5(:,:,2,1,2,2) =tens532;
tens5(:,:,2,1,2,3) =tens533;
tens5(:,:,2,1,3,1) =tens534;
tens5(:,:,2,1,3,2) =tens535;
tens5(:,:,2,1,3,3) =tens536;
tens5(:,:,2,2,1,1) =tens537;
tens5(:,:,2,2,1,2) =tens538;
tens5(:,:,2,2,1,3) =tens539;
tens5(:,:,2,2,2,1) =tens540;
tens5(:,:,2,2,2,2) =tens541;
tens5(:,:,2,2,2,3) =tens542;
tens5(:,:,2,2,3,1) =tens543;
tens5(:,:,2,2,3,2) =tens544;
tens5(:,:,2,2,3,3) =tens545;
tens5(:,:,2,3,1,1) =tens546;
tens5(:,:,2,3,1,2) =tens547;
tens5(:,:,2,3,1,3) =tens548;
tens5(:,:,2,3,2,1) =tens549;
tens5(:,:,2,3,2,2) =tens550;
tens5(:,:,2,3,2,3) =tens551;
tens5(:,:,2,3,3,1) =tens552;
tens5(:,:,2,3,3,2) =tens553;
tens5(:,:,2,3,3,3) =tens554;
tens5(:,:,3,1,1,1) =tens555;
tens5(:,:,3,1,1,2) =tens556;
tens5(:,:,3,1,1,3) =tens557;
tens5(:,:,3,1,2,1) =tens558;
tens5(:,:,3,1,2,2) =tens559;
tens5(:,:,3,1,2,3) =tens560;
tens5(:,:,3,1,3,1) =tens561;
tens5(:,:,3,1,3,2) =tens562;
tens5(:,:,3,1,3,3) =tens563;
tens5(:,:,3,2,1,1) =tens564;
tens5(:,:,3,2,1,2) =tens565;
tens5(:,:,3,2,1,3) =tens566;
tens5(:,:,3,2,2,1) =tens567;
tens5(:,:,3,2,2,2) =tens568;
tens5(:,:,3,2,2,3) =tens569;
tens5(:,:,3,2,3,1) =tens570;
tens5(:,:,3,2,3,2) =tens571;
tens5(:,:,3,2,3,3) =tens572;
tens5(:,:,3,3,1,1) =tens573;
tens5(:,:,3,3,1,2) =tens574;
tens5(:,:,3,3,1,3) =tens575;
tens5(:,:,3,3,2,1) =tens576;
tens5(:,:,3,3,2,2) =tens577;
tens5(:,:,3,3,2,3) =tens578;
tens5(:,:,3,3,3,1) =tens579;
tens5(:,:,3,3,3,2) =tens580;
tens5(:,:,3,3,3,3) =tens581;
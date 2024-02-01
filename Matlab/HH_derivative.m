function dX = HH_derivative(X, I)
   
    v= X(1); m = X(2); n = X(3); h = X(4);
    dv = -  I - (120*m^3*h*(v+115) + 36*n^4*(v-12) + 0.3*(v+10.599));
    dm = (1-m)*Psi((v+25)/10) - m*4*exp(v/18);
    dn = (1-n)*0.1*Psi((v+10)/10) - n*0.125*exp(v/80);
    dh = (1-h)*0.07*exp(v/20) - h/(1+exp((v+30)/10));
    
    dX = [dv, dm, dn, dh];

end

function y = Psi(x)
    y = x/(exp(x)-1);
end

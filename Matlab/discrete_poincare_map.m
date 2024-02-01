function point = discrete_poincare_map(X0, I, dt)
   
   X = [-4.5, X0];
   previous_v = X(1);
   while not(X(1) > -4.50001 && X(1) < -4.49999 && X(1)>previous_v)
       previous_v = X(1);
       X = X + dt*HH_derivative(X, I);
   end

   point = X(2:4);
end

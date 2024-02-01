function data = HH_simulator(X0, I, dt, T)
    
    n_t = round(T/abs(dt));
    X = X0;
    store = zeros(n_t, 5);
    
    for i = 1:n_t
        X = X + HH_derivative(X, I)*dt;
        store(i, :) = [i*abs(dt), X];
    end
    
    data = store;
end



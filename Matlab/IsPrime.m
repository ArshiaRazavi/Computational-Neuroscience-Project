function result = IsPrime(N)
    result = true;
    if N == 1 || N == 2
        result = false;
    end

    for i = 2:round(N/2)
        if mod(N, i) == 0
            result = false;
            break
        end
    end
end

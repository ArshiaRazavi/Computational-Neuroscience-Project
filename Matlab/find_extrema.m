function extrema = find_extrema(signal)
    min = -findpeaks(-signal(:,2));
    max = findpeaks(signal(:,2));

    size = round((length(min)+length(max))/2)-1;
    extrema = zeros(2*size,1);
    
    for i = 1:size
        extrema(2*i-1) = min(i);
        extrema(2*i) = max(i);
    end
end

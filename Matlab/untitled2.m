

for I = 6.20 : 0.001 : 6.30
    data = HH_simulator([0, 0.5,0.5,0.5], I, 0.001, 500);
    extrema = find_extrema(data(300000:end,:));
    plot(I, extrema, 'r.')
    hold on
end

hold off





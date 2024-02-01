
T = 1000;
I = 14.2211827403;
data = HH_simulator([-11, 0.3, 0.5, 0.5], I, 0.0001, T);
data = HH_simulator(data(end,2:5), I, 0.001, T);

plot(data(:, 2), data(:, 5))
xlabel("v")
ylabel("h")
xlim([-100, 20])
ylim([0.35, 0.8 ])


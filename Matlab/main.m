clear
clc

%N_v = 2; N_m = 5; N_n = 5; N_h = 5; 

%v_max = 0; v_min = -10;
%m_max = 1; m_min = 0;
%n_max = 0.8; n_min = 0.4;
%h_max = 0.5; h_min = 0;

%v = v_min:(v_max-v_min)/N_v:v_max;
%m = m_min:(m_max-m_min)/N_m:m_max;
%n = n_min:(n_max-n_min)/N_n:n_max;
%h = h_min:(h_max-h_min)/N_h:h_max;    

%data = [];

  
for j = 1:N_m
    for k = 1:N_n
        for l = 1:N_h
            signal = HH_simulator([-4.5, m(j), n(k), h(l)], 8, 0.001, 100);
            extrema = find_extrema(signal);
            distance = zeros(length(extrema)-1, 1);
            for i = 1:length(distance)
                distance(i) = abs(extrema(i) - extrema(i+1));
            end
            if distance(end) > 1 && distance(end) < 70
                data = [data, extrema'];   
            end
           
        end
    end
end
        


%distance = zeros(length(extrema)-1, 1);
%for i = 1:length(distance)
%    distance(i) = abs(extrema(i) - extrema(i+1));
%end

%subplot(2,1,1)
%%plot(distance, 'r.')
%%subplot(2,1,2)
%%plot(data(:,5), data(:,2))


hist(data, 100)

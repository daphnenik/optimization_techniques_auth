% Ορίζουμε τις συναρτήσεις f1(x), f2(x), και f3(x)
f1 = @(x) (x - 1).^3 + (x - 4).^2 .* cos(x);
f2 = @(x) exp(-2 .* x) + (x - 2).^2;
f3 = @(x) x.^2 .* log(0.5 .* x) + sin(0.2 .* x).^2;

x = 0:0.01:3; 

% Υπολογισμός των συναρτήσεων
y1 = f1(x);
y2 = f2(x);
y3 = f3(x);

% Δημιουργία γραφικών παραστάσεων των συναρτήσεων
figure;  
subplot(3,1,1);  
plot(x, y1);
title('f1(x) = (x - 1)^3 + (x - 4)^2 * cos(x)');

subplot(3,1,2);  
plot(x, y2);
title('f2(x) = exp(-2 * x) + (x - 2)^2');

subplot(3,1,3);  
plot(x, y3);
title('f3(x) = x^2 * log(0.5 * x) + sin(0.2 * x)^2');

% Ορίζουμε το τελικό εύρος αναζήτησης l
l = 0.01;

% Υλοποιούμετον αλγόριθμο για διάφορες τιμές της παραμέτρου ε
epsilons = 0.0001:0.0002:0.0048;  % List of epsilon values
num_evaluations_per_epsilon = zeros(3, length(epsilons));

for i = 1:length(epsilons)
    epsilon = epsilons(i);
    [~,num_evaluations_f1] = bisection_method(f1, 0, 3, epsilon,l);
    [~,num_evaluations_f2] = bisection_method(f2, 0, 3, epsilon,l);
    [~,num_evaluations_f3] = bisection_method(f3, 0, 3, epsilon,l);
    num_evaluations_per_epsilon(1, i) = num_evaluations_f1;
    num_evaluations_per_epsilon(2, i) = num_evaluations_f2;
    num_evaluations_per_epsilon(3, i) = num_evaluations_f3;
end

% Δημιουργούμε γραφικές παραστάσεις για τον αριθμό των κλήσεων της αντικειμενικής συνάρτησης
% Define the number of subplots in each row and column
num_rows = 3;
num_cols = 1;

figure;

for i = 1:3
    subplot(num_rows, num_cols, i); 
    semilogx(epsilons, num_evaluations_per_epsilon(i, :), '-o', 'DisplayName', ['f' num2str(i) '(x)']);
    xlabel('Παράμετρος \epsilon');
    ylabel(['Αριθμός υπολογισμών της f' num2str(i)]);
    legend;
    title(['Επίδραση της παραμέτρου \epsilon στον αριθμό των υπολογισμών της f' num2str(i)]);
end

% Τώρα θα εξετάσουμε την επίδραση της παραμέτρου l (τελικό εύρος αναζήτησης) στον αριθμό των κλήσεων
epsilon = 0.001;
l_values = 0.005:0.002:0.1;
num_evaluations_per_l = zeros(3, length(l_values));

for i = 1:length(l_values)
    l = l_values(i);
    [~,num_evaluations_f1] = bisection_method(f1, 0, 3, epsilon,l);
    num_evaluations_per_l(1, i) = num_evaluations_f1;
    [~,num_evaluations_f2] = bisection_method(f2, 0, 3, epsilon,l);
     num_evaluations_per_l(2, i) = num_evaluations_f2;
    [~,num_evaluations_f3] = bisection_method(f3, 0, 3, epsilon,l);
    num_evaluations_per_l(3, i) = num_evaluations_f3;
end


num_rows = 3;
num_cols = 1;

figure;

for i = 1:3
    subplot(num_rows, num_cols, i); % Create a subplot
    semilogx(l_values, num_evaluations_per_l(i, :), '-o', 'DisplayName', ['f' num2str(i) '(x)']);
    xlabel('Παράμετρος l');
     ylabel(['Αριθμός υπολογισμών της f' num2str(i)]);
    legend;
    title(['Επίδραση της παραμέτρου l στον αριθμό των υπολογισμών της f' num2str(i)]);
end

% Τώρα θα εξετάσουμε την επίδραση της παραμέτρου l (τελικό εύρος αναζήτησης) στα άκρα του διαστήματος [ak,bk]  
% Ορίζουμε τις διάφορες τιμές της παραμέτρου l
l_values = [0.004, 0.01, 0.05, 0.2];
epsilon = 0.001;

figure;

for i = 1:length(l_values)
    l = l_values(i); % Ορίζουμε το μήκος του διαστήματος ως την τρέχουσα τιμή της l
    [~, ~, a_values, b_values] = bisection_method(f1, 0, 3, epsilon, l);
    
    % Δημιουργούμε τα γραφήματα για τα a_values και b_values
    subplot(2, 2, i); % Δημιουργούμε υπο-γραφήματα 2x2 για κάθε τιμή της l
    plot(1:length(a_values), a_values, '-o', 'DisplayName', 'a_k');
    hold on;
    plot(1:length(b_values), b_values, '-o', 'DisplayName', 'b_k');
    xlabel('Βήμα k');
    ylabel('Τιμή a_k ή b_k');
    title(['f1 - Άκρα του διαστήματος [a_k, b_k] για l = ' num2str(l)]);
    legend;
end

figure;
for i = 1:length(l_values)
    l = l_values(i); % Ορίζουμε το μήκος του διαστήματος ως την τρέχουσα τιμή της l
    [~, ~, a_values, b_values] = bisection_method(f2, 0, 3, epsilon, l);
    
    % Δημιουργούμε τα γραφήματα για τα a_values και b_values
    subplot(2, 2, i); % Δημιουργούμε υπο-γραφήματα 2x2 για κάθε τιμή της l
    plot(1:length(a_values), a_values, '-o', 'DisplayName', 'a_k');
    hold on;
    plot(1:length(b_values), b_values, '-o', 'DisplayName', 'b_k');
    xlabel('Βήμα k');
    ylabel('Τιμή a_k ή b_k');
    title(['f2 - Άκρα του διαστήματος [a_k, b_k] για l = ' num2str(l)]);
    legend;
end

figure;
for i = 1:length(l_values)
    l = l_values(i); % Ορίζουμε το μήκος του διαστήματος ως την τρέχουσα τιμή της l
    [~, ~, a_values, b_values] = bisection_method(f3, 0, 3, epsilon, l);
    
    % Δημιουργούμε τα γραφήματα για τα a_values και b_values
    subplot(2, 2, i); % Δημιουργούμε υπο-γραφήματα 2x2 για κάθε τιμή της l
    plot(1:length(a_values), a_values, '-o', 'DisplayName', 'a_k');
    hold on;
    plot(1:length(b_values), b_values, '-o', 'DisplayName', 'b_k');
    xlabel('Βήμα k');
    ylabel('Τιμή a_k ή b_k');
    title(['f3 - Άκρα του διαστήματος [a_k, b_k] για l = ' num2str(l)]);
    legend;
end


% Συνάρτηση διχοτόμου
function [min_x, num_evaluations,a_values, b_values] = bisection_method(f, a, b, epsilon, l)
    k = 1;
    a_values = [a]; % Κρατάμε τις τιμές του a σε κάθε επανάληψη
    b_values = [b]; % Κρατάμε τις τιμές του b σε κάθε επανάληψη
    while (b - a) > l
       k = k + 1;
       mid = (a + b) / 2;
        if f(mid - epsilon) < f(mid + epsilon)
            b = mid + epsilon;
        else
            a = mid - epsilon;
        end
        a_values = [a_values a]; % Αποθηκεύουμε το νέο a
        b_values = [b_values b]; % Αποθηκεύουμε το νέο b
    end
    min_x = (a + b) / 2;
    num_evaluations = 2*k;
end
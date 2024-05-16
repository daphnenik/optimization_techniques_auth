% Ορισμός των συναρτήσεων
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) x^2 * log(0.5 * x) + sin(0.2 * x)^2;

% Υπολογισμός για διάφορες τιμές του l
a = 0;
b = 3;
l_values = 0.005:0.002:0.1;

num_evaluations_per_l = zeros(3, length(l_values));

for i = 1:length(l_values)
    l = l_values(i);
    [ ~,~,n1] = golden_section(f1, l);
    num_evaluations_per_l(1, i) = n1;
    [ ~,~,n2]= golden_section(f2, l);
    num_evaluations_per_l(2, i) = n2;
    [ ~,~,n3 ]= golden_section(f3,  l);
    num_evaluations_per_l(3, i) = n3;
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

% Δημιουργούμε ένα κενό figure για την απεικόνιση των γραφημάτων
figure;

for i = 1:length(l_values)
    l = l_values(i); % Ορίζουμε το μήκος του διαστήματος ως την τρέχουσα τιμή της l
    [ a_values, b_values, ~] = golden_section(f1, l);
    
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
    [ a_values, b_values, ~] = golden_section(f2, l);
    
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
    [ a_values, b_values, ~] = golden_section(f3, l);
    
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


% Υλοποίηση της Μεθόδου του Χρυσού Τομέα
function [a,b,n,l] = golden_section(f,lamda)

n = 1; g = 0.618; a = []; b = [];
l = lamda;
a(n) = 0; b(n) = 3;
x_1 = a(n) + (1 - g)*(b(n) - a(n));
x_2 = a(n) + g*(b(n) - a(n));
while b(n)-a(n)>l
    n = n + 1;
    if f(x_1) > f(x_2)
        a(n) = x_1;
        x_1 = x_2;
        b(n) = b(n-1);
        x_2 = a(n) + g*(b(n) - a(n));
    else
        a(n) = a(n-1);
        b(n) = x_2;
        x_2 = x_1;
        x_1 = a(n) + (1 - g)*(b(n) - a(n));
    end
end
end
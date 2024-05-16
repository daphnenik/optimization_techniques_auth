% Ορισμός των συναρτήσεων
syms x; 
f1 = (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = exp(-2 * x) + (x - 2)^2;
f3 = x^2 * log(0.5 * x) + sin(0.2 * x)^2;

%Υπολογισμός των παραγώγων των συναρτήσεων
df1 = diff(f1);
df2 = diff(f2);
df3 = diff(f2);

% Υπολογισμός για διάφορες τιμές του l
a = 0;
b = 3;
l_values = 0.005:0.002:0.1;

num_evaluations_per_l = zeros(3, length(l_values));

for i = 1:length(l_values)
    l = l_values(i);
    [ ~,~,num_evals1] = bisection_der(df1, l);
    num_evaluations_per_l(1, i) = num_evals1;
    [ ~,~,num_evals2]= bisection_der(df2, l);
    num_evaluations_per_l(2, i) = num_evals2;
    [ ~,~,num_evals3 ]= bisection_der(df3,  l);
    num_evaluations_per_l(3, i) = num_evals3;
end

% Αριθμός των υπογραφημάτων σε κάθε γραμμή και στήλη
num_rows = 3;
num_cols = 1;

figure;


for i = 1:3
    subplot(num_rows, num_cols, i); 
    semilogx(l_values, num_evaluations_per_l(i, :), '-o', 'DisplayName', ['f' num2str(i) '(x)']);
    xlabel('Παράμετρος l');
     ylabel(['Αριθμός υπολογισμών της f' num2str(i)]);
    legend;
    title(['Επίδραση της παραμέτρου l στον αριθμό των υπολογισμών της f' num2str(i)]);
end

% Τώρα θα εξετάσουμε την επίδραση της παραμέτρου l (τελικό εύρος αναζήτησης)στα άκρα του διαστήματος [ak,bk]  
% Ορίζουμε τις διάφορες τιμές της παραμέτρου l
l_values = [0.004, 0.01, 0.05, 0.2];

figure;

for i = 1:length(l_values)
    l = l_values(i); % Ορίζουμε το μήκος του διαστήματος ως την τρέχουσα τιμή της l
    [ a_values, b_values, ~] = bisection_der(df1, l);
    
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
    [ a_values, b_values, ~] = bisection_der(df2, l);
    
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
    [ a_values, b_values, ~] = bisection_der(df3, l);
    
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

function [a,b,k,l] = bisection_der(df,l)
k = 1; a = []; b= []; n = 0; 
a(k) = 0; b(k) = 3;

while( n<log2((b(k) - a(k))/ l))
    n = n+1;
end

for k = 1:n
    x1 = (a(k) + b(k))/2;
    value = subs(df,x1);
    if value == 0
        return
    elseif value > 0
        a(k+1) = a(k);
        b(k+1) = x1;
    elseif value < 0
        a(k+1) = x1;
        b(k+1) = b(k);
    end
end

end
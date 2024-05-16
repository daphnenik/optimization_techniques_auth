function [child1,child2] = crossover(A, B,chromosomes)
    
for j = 1:chromosomes
    
    % Convert values to binary
    precision_bits = 10;
    bin1 = dec2bin(round((A(j) + 1) * (2^precision_bits - 1) / 2), precision_bits);
    bin2 = dec2bin(round((B(j) + 1) * (2^precision_bits - 1) / 2), precision_bits);
    
    % Both binary strings should have the same length
    maxLength = max(length(bin1), length(bin2));
    bin1 = sprintf('%0*s', maxLength, bin1);
    bin2 = sprintf('%0*s', maxLength, bin2);
    
    split_index=randi(maxLength-1); %splitting point
    
    %Crossover process
    child_bin1 = [bin1(1:split_index), bin2(split_index+1:end)];
    child_bin2 = [bin2(1:split_index), bin1(split_index+1:end)];
    
    
    % Convert the binary string back to decimal
    child1(j) = 2 * bin2dec(child_bin1) / (2^precision_bits - 1) - 1;
    child2(j) = 2 * bin2dec(child_bin2) / (2^precision_bits - 1) - 1;   
end
end

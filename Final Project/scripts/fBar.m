function gaussian_val = fBar(u1Bar,u2Bar,genes,size)
% Function to calculate value of each Gaussian.

gaussian_val = 0;

for i = 1:5:size
    A = genes(i);
    c1 = genes(i+1);
    c2 = genes(i+2);
    s1 = genes(i+3);
    s2 = genes(i+4);
    gpow = ((u1Bar-c1)^2/(2*s1^2)) + ((u2Bar-c2)^2/(2*s2^2));
    gaussian_val = gaussian_val + A * exp(-gpow);
end
end


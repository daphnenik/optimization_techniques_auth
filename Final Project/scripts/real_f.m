function [val] = real_f(u1,u2)
%f(u1,u2) used to create the data and evaluate our results
val = sin(u1+u2).*sin(u2.^2);
end


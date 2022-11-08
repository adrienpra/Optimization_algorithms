function [f_ap] = F_apr(x)

global A

xx = x(:,1);
yy = x(:,2);

AA = [ones(length(xx)), xx, yy, xx.^2,xx.*yy, yy.^2];
f_ap = A'*AA';

end
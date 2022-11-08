function [x] = Surf_Rep()

global A

LB = [-1 -1];
UB = [1 1];
x0 = [0 0];

x = [-1 -1 1 1 -1 1 0 0 0];
y = [-1 1 -1 1 0 0 -1 1 0];
f = [3654 2975 195 184 2288 190 1312 184 261];

M = [9 sum(x) sum(y) sum(x.^2) sum(x.*y) sum(y.^2); 
    sum(x) sum(x.^2) sum(x.*y) sum(x.^3) sum(y.*x.^2) sum(x.*y.^2);
    sum(y) sum(x.*y) sum(y.^2) sum(y.*x.^2) sum(x.*y.^2) sum(y.^3);
    sum(x.^2) sum(x.^3) sum(y.*x.^2) sum(x.^4) sum(y.*x.^3) sum(x.^2.*y.^2);
    sum(x.*y) sum(y.*x.^2) sum(x.*y.^2) sum(y.*x.^3) sum(x.^2.*y.^2) sum(x.*y.^3);
    sum(y.^2) sum(x.*y.^2) sum(y.^3) sum(x.^2.*y.^2) sum(x.*y.^3) sum(y.^4)];

B = [sum(f) sum(f.*x) sum(f.*y) sum(f.*x.^2) sum(f.*x.*y) sum(f.*y.^2)]';

A = pinv(M)*B;

X = -1:0.05:1;
Y = -1:0.05:1;

    for i=1:length(X)
        for j=1:length(Y)
            P = [1 X(i) Y(j) X(i)^2 X(i)*Y(j) Y(j)^2]; %base polynomiale
            F_app(i,j) = P*A;
        end
    end
    
[XX, YY] = meshgrid(X);

h = figure;
filename = 'testAnimated.gif';
axis tight manual % this ensures that getframe() returns a consistent size

s = surf(XX, YY, F_app);
obj = VideoWriter('Surf_rep');
obj.Quality = 100;
objFrameRate = 15;
open(obj);

for az =720:-1:0
    title('RSM')
    xlabel('C')
    ylabel('B')
    zlabel('F_obj')
    view(az,5)
    f =getframe(gcf);
    writeVideo(obj,f);
    pause(0.05)
    
end

[x] = fmincon(@F_apr, x0, [], [], [], [], LB, UB)


end


clear all;

%variables utilisateurs
X0 = 1.5;
a0 = 0.02;
it = 50;
e = 10^-6;
dk = zeros(it,1);
Xmin = -5;
Xmax = 5;
Ymin = -5;
Ymax = 100;

X = zeros(it,1);
X(1) = X0;
i=1;
verif=0;

%définition fonction
syms x
func = 4*x^2 + exp(x)+ x;

[u,v] = meshgrid(Xmin:0.1:Xmax, Ymin:0.1:Ymax);

%itération
while 1
    
    dk(i) = eval(subs( diff(func,x,1),x,X(i)) );
    X(i+1) = X(i) - a0*dk(i);
    
    if abs(X(i)-X(i+1))< e
        fprintf('fin du calcul au bout de %d itérations\n', i);
        Result = ['x = ' ,num2str(X(i+1))];
        disp(Result)
        verif=1;
        break
    end
    i = i+1;
    
    if i == it
        break
    end
    
end

if verif==0
    disp('le calcul a pas convergé selon le critère rentré\n');
    fprintf('fin du calcul au bout de %d itérations\n', i);
    Result = ['x = ' ,num2str(X(i))];
    disp(Result)
end

fplot(func)
grid on
hold on

for j = 1:i
    
    %plot(X(j),eval(subs(func,x,X(j))),'r*');
    %tan = @(y) (dk(j)*(y-X(j)) + eval(subs(func,x,X(j))));
    %fplot(tan,[X(j)-1 X(j)+1],'g');
    
end





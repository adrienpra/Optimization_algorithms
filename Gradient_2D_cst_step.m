clear;

%définition fonction

syms x
syms y
func = x^2 +4*y^2;

%variables utilisateurs
X0 = 1.5;
Y0 = 1.5;
a0 = 0.02;
it = 1000;
e = 10^-6;
dk = zeros(it,2);
Xmin = -5;
Xmax = 5;
Ymin = -5;
Ymax = 100;

X = zeros(it,1);
X(1) = X0;
Y = zeros(it,1);
Y(1) = Y0;

i=1;
verif=0;

[u,v] = meshgrid(Xmin:0.1:Xmax, Ymin:0.1:Ymax);
fmesh(func)

%itération
while 1
    
    dk(i,1) = eval(subs( diff(func,x,1),x,X(i)));
    dk(i,2) =  eval(subs( diff(func,y,1),y,Y(i)));
    X(i+1) = X(i) - a0*dk(i,1);
    Y(i+1) = Y(i) - a0*dk(i,1);
    
    if (abs(X(i)-X(i+1))< e) && (abs(Y(i)-Y(i+1))< e)
        fprintf('fin du calcul au bout de %d itérations\n', i);
        Result_x = ['x = ' ,num2str(X(i+1))];
        Result_y = ['y = ' ,num2str(Y(i+1))];
        disp(Result_x)
        disp(Result_y)
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
    Result_x = ['x = ' ,num2str(X(i))];
    Result_y = ['y = ' ,num2str(Y(i))];
    disp(Result_x)
    disp(Result_y)
end




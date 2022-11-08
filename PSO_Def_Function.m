function F = Method_PSO_Def_Function(x) %x doesn't explicit the dimension of the var

    global w c1 c2 it Space_lb Space_ub wdamp nPop
    
    w = 1;                  %Inertia Coeff
    c1 = 2;                 %Personal Acceleration Coeff
    c2 = 2;                 %Global Acceleration Coeff
    it = 200;                %Max iterations
    Space_lb = -10;         %Lower boundary
    Space_ub = 10;          %Upper boundary
    wdamp = 0.9;            %Damping the inertia coef through iteration
    nPop = 20;              %Number of Particle
    
    %change Var_Size if needed !!
    F = sum(x.^2);          %Function to approximate
                            %x(1)^2 + x(2)^2 eq to sum(x.^2)
end
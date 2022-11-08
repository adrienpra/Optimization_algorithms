    %kill all previous variables before run (cause pbs when change var)
clear;

    %Var definition in Method_PSO_Def_Function.m file
global w c1 c2 it Space_lb Space_ub wdamp nPop

Var_Size = [1 2];   %nombre de variable
    
    %Create Particle's var spaces
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];
particle = repmat(empty_particle,nPop,1);  %create nPop copy of empty_particle class
GlobalBest.Cost = inf;                     %Infinite value 
GlobalBest.Position = [];

    %Initialisation
for i=1:nPop
        
            %initialize first values
        particle(i).Position = unifrnd(Space_lb,Space_ub,Var_Size);
        particle(i).Velocity = zeros(Var_Size);
        particle(i).Cost = Method_PSO_Def_Function(particle(i).Position);
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;
        
        if particle(i).Best.Cost < GlobalBest.Cost
            
            GlobalBest.Cost = particle(i).Best.Cost;
            GlobalBest.Position = particle(i).Best.Position;
        end 
end

    r1 = rand(Var_Size);   %Uniformly distributed pseudorandom number r1
    r2 = rand(Var_Size);   %Uniformly distributed pseudorandom number r2
    
    %Iteration
for k =1:it
  
    for i=1:nPop
        
        %update particle Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
        + c1*r1.*(particle(i).Best.Position - particle(i).Position) ...
        + c2*r2.*(GlobalBest.Position - particle(i).Position);
        %update particle Position
        particle(i).Position = particle(i).Velocity + particle(i).Position;
        %update particle Cost
        particle(i).Cost = Method_PSO_Def_Function(particle(i).Position);
        
        %update particle Best Position/Cost
        if particle(i).Cost < particle(i).Best.Cost
            
            particle(i).Best.Cost = particle(i).Cost;
            particle(i).Best.Position = particle(i).Position;
            
            if particle(i).Best.Cost < GlobalBest.Cost
                
                GlobalBest = particle(i).Best;
            end
        end
    end
    
    w = wdamp*w;
end

disp(GlobalBest.Position);


w1=0.5; %weight of the first objective
w2=0.5; %weight of the second objective
obj1_n=[2 , 2 ]; %numerator of the first objective, max
obj2_n=[-2 , -3 ]; %numerator of the second objective? min
obj1_2_d=[5, 4, 4]; %the common denominator of the two objective functions

LHS_C=[1 2  ; 2 0  ; 0 3 ]; %LHS of the constraints
RHS_C=[7;5;13]; %RHS of the constraints

obj1_n(end+1)=0; %add the coefficient of the new variable meu to the first objective
obj2_n(end+1)=0; %add the coefficient of the new variable meu to the second objective

LHS_C(:,end+1)=0; %add to the LHS of all the constraints the coefficient of the new variable meu

%multiply the objective functions by the weights and -1, since they are
%maximization, and add them together to have a single objective
obj=-1*w1*obj1_n +w2*obj2_n;

LHS_C(:,3)=-1*RHS_C; %get the RHS to the LHS by negative sign , because it now contains variable meu

RHS_C(:,1)=0; %now the RHS is zero

N_LHS_C=cat(1,LHS_C, obj1_2_d,-1*obj1_2_d); %add the new equality constraint of the meu as 2 equations, one greater than and one less than

N_RHS_C=cat(1,RHS_C,[1;-1]); % add the RHS of the two new constraints which is 1 & -1

%solve the new problem using linear programming function
lb=zeros(3,1);
[x,fval]=linprog(obj,N_LHS_C,N_RHS_C,[],[],lb);
fprintf('The optimal objective function value :')
z=fval %The new equation is now min, no need to multiply by -1
fprintf('The optimal values of the decision variables')
x

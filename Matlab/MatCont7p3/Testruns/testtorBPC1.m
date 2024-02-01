clear all
p=[0.5;-0.6;0.6;0.32858;0.93358;-0.9;0.001];
x=[0.00125;-0.001;0.00052502];
[x0,v0]=init_EP_EP(@torBPC,x,p,[6]);
opt=contset;
opt=contset(opt,'Singularities',1);
opt=contset(opt,'MaxNumPoints',10);
[x,v,s,h,f]=cont(@equilibrium,x0,[],opt);
x1=x(1:3,s(2).index);
p(6)=x(end,s(2).index);
[x0,v0]=init_H_LC(@torBPC,x1,p,[6],0.0001,25,4);
opt=contset;
opt=contset(opt,'Singularities',1);
opt=contset(opt,'Multipliers',1);
opt=contset(opt,'MaxNumPoints',50);
[x,v,s,h,f]=cont(@limitcycle,x0,v0,opt);
plotcycle(x,v,s,[1,2]);
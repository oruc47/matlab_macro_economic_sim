clear all

beta = 0.987;
alpha = 0.4;
teta = 0.64;
delta= 0.012;
dz  = (1-teta)/(teta*(1-alpha)); %derived utility
sim = 1;

std_dev = 0.007; 
rho = 0.95;

%estimates used from Cooley and Prescott (1995)

if sim == 1

N1 = 1000;
N2 = 2;

T  = 1000;

kv = 55 + 0.0075*(1:N1);%constants given by professor 

zv = exp(std_dev*(0:N2-1)); %sigma squared matrix

pv = [rho, 1-rho; 1-rho, rho]; %stochastic matrix

V = zeros(N1,N2);

distance = 1;
nv  = 0.5*ones(1,N1);

%value function iteration
while distance>0.0001
   for i=1:N1
       for j=1:N2
           dist = 1;
           while dist>0.0001
               nvp = (1/(1+dz))+(dz/(1+dz))*((kv-(1-delta)*kv(i))./(zv(j)*kv(i)^alpha)).*(nv.^alpha); 
               dist   = sum((nv-nvp).^2); %squared distance but can be done with abs
               nv = nvp;
           end
           nv = min(0.999999,max(0.0000001,nv));
           [Vp(i,j),kp(i,j)] = max(teta*log(max(0.0000001,zv(j)*(kv(i).^alpha).*(nv.^(1-alpha))+(1-delta)*kv(i)-kv)) ....
              +(1-teta)*log(max(0.0000001,1-nv))+beta*(pv(j,1)*V(:,1)'+pv(j,2)*V(:,2)'));
           nj(i,j) = nv(kp(i,j));
       end
   end   
   distance = sum(sum((V-Vp).^2))
   V = 0.0*V+ 1.0*Vp;
end

k0j= 500;
kj(1) = k0j;
sv = rand(1,T);
jv(1) = 1;

%determine capital, labor, output for next period
for i=1:T
    kj(i+1) = kp(kj(i),jv(i));
    lj(i) = nj(kj(i),jv(i));
    if (sv(i) > pv(1,1)) & (jv(i) == 1)
        jv(i+1) = 2;
    elseif (sv(i) > pv(2,2)) & (jv(i) == 2)
        jv(i+1) = 1;
    elseif (sv(i) < pv(1,1)) & (jv(i) == 1)
        jv(i+1) = 1;
    else jv(i+1) = 2;
    end
end
       
kt = kv(kj);
yt = zv(jv(1:T)).*kt(1:T).^alpha.*lj.^(1-alpha);
it = kt(2:T+1)-(1-delta)*kt(1:T);
ct = yt-it; 
rt = ((((ct(2:T)./ct(1:T-1)))*((1+delta)/beta))-1)*100;
wt = (1-alpha)*zv(jv(1:T)).*kt(1:T).^alpha.*lj.^(-alpha);
ot = yt./lj; %output per worker

save rbcdata

end

if sim == 2
    load rbcdata
end

plot(1:T+1,kt);
title('Evolution of Capital Stock');
xlabel('Time');
ylabel('Capital Stock');
pause


plot(1:T,ct);
title('Evolution of Consumption');
xlabel('Time');
ylabel('Consumption');
pause

stdyt = std(yt)/mean(yt) %output
stdct = std(ct)/mean(ct) %consumption
pause
stdit = std(it)/mean(it) %investment
stdlt = std(lj)/mean(lj) %hours worked
stdwt = std(wt)/mean(wt) %wage
pause
stdot = std(ot)/mean(ot) %labor productivity
pause
corct = corrcoef(yt,ct) %output consumption cor
corit = corrcoef(yt,it) %output investment cor
pause
corlt = corrcoef(yt,lj) %output hours worked cor
corwt = corrcoef(yt,wt) %output wage
pause
corrt = corrcoef(yt,rt)
corwt = corrcoef(yt,ot) %output labor productivity cor









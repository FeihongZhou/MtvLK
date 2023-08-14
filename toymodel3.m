clear all

q = 1000;%realization
r = 2000;%t
x1 = zeros(q,r);
x2 = x1;
x3 = x1;
x4 = x1;
x5 = x1;

ep1 = x1;
ep2 = x2;
ep3 = x3;
ep4 = x4;
ep5 = x5;

for ii = 1:q
    %     ii = 1;
    x1(ii,1) = rand(1,1);
    x2(ii,1) = rand(1,1);
    x3(ii,1) = rand(1,1);
    x4(ii,1) = rand(1,1);
    x5(ii,1) = rand(1,1);
    
    ep1(ii,:) = normrnd(0,1,1,r);
    ep2(ii,:) = normrnd(0,1,1,r);
    ep3(ii,:) = normrnd(0,1,1,r);
    ep4(ii,:) = normrnd(0,1,1,r);
    ep5(ii,:) = normrnd(0,1,1,r);
    
    for i = 2:r
        if i<=500
            c12 = 0;
            c15 = 0;
            c23 = 0;
            c24 = 0;
            c34 = 0;
            c45 = 0;
        end
        if i>500 && i<=1500
            c12 = 0+(i-500)*0.0005;
            c15 = 0+(i-500)*0.0005;
            c23 = 0+(i-500)*0.0005;
            c24 = 0+(i-500)*0.0005;
            c34 = 0+(i-500)*0.0005;
            c45 = 0+(i-500)*0.0005;
            c51 = 0+(i-500)*0.0005;
            c35 = 0+(i-500)*0.0005;
        end
        if i>1500
            c12 = 0.5;
            c15 = 0.5;
            c23 = 0.5;
            c24 = 0.5;
            c34 = 0.5;
            c45 = 0.5;
        end
        x1(ii,i)= 0.35 * x1(ii,i-1) + ep1(ii,i);
        x2(ii,i)= 0.35 * x2(ii,i-1) + c12 * x1(ii,i-1) + ep2(ii,i);
        x3(ii,i)= 0.35 * x3(ii,i-1) + c23 * x2(ii,i-1) + ep3(ii,i);
        x4(ii,i)= 0.35 * x4(ii,i-1) + c24 * x2(ii,i-1) + c34 * x3(ii,i-1) + ep4(ii,i);
        x5(ii,i)= 0.35 * x5(ii,i-1) + c15 * x1(ii,i-1) + c45 * x4(ii,i-1) + ep5(ii,i);
        
    end
    x1mean=nanmean(x1,1)';
    x2mean=nanmean(x2,1)';
    x3mean=nanmean(x3,1)';
    x4mean=nanmean(x4,1)';
    x5mean=nanmean(x5,1)';
    
end
save('toymodel3.mat','x1','x2','x3','x4','x5','x1mean','x2mean','x3mean','x4mean','x5mean');



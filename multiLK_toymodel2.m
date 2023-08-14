
clear

load toymodel2.mat
MAlen_shuru = 10;
NN_shuru =290;
MA_shuru = 'UWMA';
np_shuru = 1;

x1_2=x1';
x2_2=x2';
x3_2=x3';

variable_realization = length(x1_2(1,:));

for r=1:variable_realization
    [T21(:,r),err90(:,r),err95(:,r),err99(:,r)] = multiLK_code(MAlen_shuru,NN_shuru,MA_shuru,np_shuru,x3_2(:,r),x2_2(:,r),x1_2(:,r));
   disp(num2str(r))
end

T21mean=nanmean(T21,2);
err90mean=nanmean(real(err90),2);
err95mean=nanmean(real(err95),2);
err99mean=nanmean(real(err99),2);

figure;plot(T21mean,'color','b','LineWidth',1);hold on;plot(err99mean,'color','r','LineWidth',1)
xlim([0 2000])

set(gca,'XTick',0:500:2000,'FontSize',12,'FontName','Times New Roman','Linewidth',1);

set(gca,'YTicklabel',{'0','0.02','0.04','0.06','0.08'});
xlabel('Time','FontSize',14,'FontName','Times New Roman')
ylabel('Information Flow','FontSize',14,'FontName','Times New Roman')
legend({'T23|1','Sig23|1'},'FontSize',12,'Location','northwest','FontName','Times New Roman')
set(gcf,'Position',[100 100 360 270]);
legend({'T_2_-_>_3_|_1','Sig_2_-_>_3_|_1'},'FontSize',12,'Location','northwest','FontName','Times New Roman')

clc
clear
load huabei.mat

MAlen_shuru = 10;
NN_shuru = 80;
MA_shuru = 'UWMA';
np_shuru = 1;


variable_realization = length(huabei_SM(1,:));
for r=1:variable_realization
    [T21(:,r),err90(:,r),err95(:,r),err99(:,r)] = multiLK_code(MAlen_shuru ,NN_shuru,MA_shuru,np_shuru,huabei_GPP(:,r),huabei_SM(:,r),huabei_VPD(:,r));
    disp(num2str(r))
end


T21mean=nanmean(T21,2);

%T21_absmean=nanmean(T21_abs,2);
err90mean=nanmean(real(err90),2);
err95mean=nanmean(real(err95),2);
err99mean=nanmean(real(err99),2);


T21mean2=T21mean(97:end,1);
err95mean2=err95mean(97:end,1);
figure;plot(T21mean2,'color','b','LineWidth',1);hold on;plot(err95mean2,'color','r','LineWidth',1);
xlim([0 360])
ylim([0 0.14])
set(gca,'XTick',0:36:360,'FontSize',12,'FontName','Times New Roman','Linewidth',1);
%set(gca,'XTick',[1 49 97 145 193 241 289 337 385 433 455]);
set(gca,'YTick',0:0.02:0.14,'FontSize',12,'FontName','Times New Roman','Linewidth',1);


set(gca,'XTicklabel',{'1989','1992','1995','1998','2001','2004','2007','2010','2013','2016',''});
set(gca,'YTicklabel',{'0','0.02','0.04','0.06','0.08','0.10','0.12','0.14'});
xlabel('Time(year)','FontSize',14,'FontName','Times New Roman')
set(gca, 'XTickLabelRotation', 45)
ylabel('Information Flow(nats/month)','FontSize',14,'FontName','Times New Roman')
set(gcf,'Position',[100 100 400 300]);

%legend({'T_S_M_-_>_G_P_P','Sig_S_M_-_>_G_P_P',},'FontSize',12,'Location','northwest','FontName','Times New Roman')
%legend({'T_S_M_-_>_G_P_P_|_V_P_D','Sig_S_M_-_>_G_P_P_|_V_P_D',},'FontSize',12,'Location','northeast','FontName','Times New Roman')
%legend({'T_V_P_D_-_>_G_P_P','Sig_V_P_D_-_>_G_P_P',},'FontSize',12,'Location','northeast','FontName','Times New Roman')
legend({'T_V_P_D_-_>_G_P_P_|_S_M','Sig_V_P_D_-_>_G_P_P_|_S_M',},'FontSize',12,'Location','northeast','FontName','Times New Roman')
%legend({'T_V_P_D_-_>_S_M','Sig_V_P_D_-_>_S_M',},'FontSize',12,'Location','northeast','FontName','Times New Roman')
%legend({'T_V_P_D_-_>_S_M_|_G_P_P','Sig_V_P_D_-_>_S_M_|_G_P_P',},'FontSize',12,'Location','northeast','FontName','Times New Roman')

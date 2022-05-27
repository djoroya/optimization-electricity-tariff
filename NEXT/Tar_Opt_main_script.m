%%
clear
load('data/mat/ex01_2013')
%%
Power_1 = load_curve_2013.Power(200:19800);
DateTime_1 = years(2)+load_curve_2013.DateTime(200:19800);
%%
Power_1 = load_curve_2013.Power;
DateTime_1 = years(2)+load_curve_2013.DateTime;
%%
iLC_1 = LoadCurve(DateTime_1,Power_1);
%%

%%
%% Generar tarifa 

np = 2;
iET_1 = generateElectricityTariff(iLC_1,np);
%
iET_1.PowerTerms  = [300 100];      %
iET_1.PowerPrices = 1e-1*[3 2];     % 
%iET_1 = genHistoricalEnergyPrice(iET_1);
iET_1.PriceEnergy = 1 +zeros(8737,1);
%%
ibill = MonthlyBill(iLC_1,iET_1);
%%
ibill = compute(ibill);

%%

clf
bar(ibill.DateTime,[ibill.Total ...
                    ibill.TotalPower ...
                    ibill.FixedPower ...
                    ibill.Energy ...
                    ibill.PowerPenalization])
legend('Total','Total Power','Fixed Power','Total Energy','Power Penalization')
ylabel('Cost (€)')


%%  plotear tarifa
figure
sty = {'LineWidth',2};

subplot(2,1,1)
plotEnergy(iET_1,sty{:})
subplot(2,1,2)
plotPower(iET_1,sty{:})
%%
iET_1 = genHistoricalEnergyPrice(iET_1);

%%
plot(iET_1.DateTime,iET_1.PriceEnergy)

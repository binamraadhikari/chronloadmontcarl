%% Sequential Monte Carlo Simulation for Failures Only
close all; clear all;
%Data Given
load_data=load('hourly_profile')
hlc_data=load_data.hourly_profile
hlc_data(8761)=0 %For Indexing only
failure_rates=[0.1 0.1 0.1 0.1 0.2 0.2 0.2]
%Failed Loads: L1,L2,L3   L1,L2,L3    L2,L3   L3      L1      L2      L3
%Failed Segments:1          2           3       4       a       b       c
%where a,b,c are points where fuses are placed between bus and load
load_loss_table=[100        100         80      40      20      40      40]
%% Generating Up and Down Sequence for all of the components in the distribution system
for i=1:length(failure_rates)
    
    failure_rate=failure_rates(i)
    %% Generating random number for N years
    N=15000 %Number of simulations
    L=125 %Length for sequence
    failure_rate_hr=[failure_rate]*1/(365*24) %Attack rate of cyber attack in attacks per hour
    repair_rate=[0.5] %Repair rate in repairs per hour
    TTF_attack{i}=-(1./failure_rate_hr).*log(rand(N,L))
    TTR_attack{i}=-(1./repair_rate).*log(rand(N,L))

    % Creating Up and Down Times
    odd=[1:2:2*L] %Up Time
    even=[2:2:2*L] %Down Time


    system_profile(:,odd)=TTF_attack{i}(:,1:end)
    system_profile(:,even)=TTR_attack{i}(:,1:end)

    %Creating complete attack profile
    graph{i}(:,:)=cumsum(system_profile,2)
    graph{i}(graph{i}>8760)=0
    %Storing Down Time for each failed segment
    graph_down_time{i}=graph{i}(:,even)
    
    [posx_lole{i} posy_lole{i}]=find(graph_down_time{i})
    
    
    %% Creating Distributions for Reliability Indices
    
    
    duration{i}=repmat(0,N,L)
    duration{i}(posx_lole{i},posy_lole{i})=TTR_attack{i}(posx_lole{i},posy_lole{i})
    
    LOEE{i}=(round(graph_down_time{i}))
    LOEE{i}(LOEE{i}==0)=8761
    LOEE{i}=((hlc_data(LOEE{i})*load_loss_table(i)).*duration{i})
    
    LOL{i}=(round(graph_down_time{i}))
    LOL{i}(LOL{i}==0)=8761
    LOL{i}=((hlc_data(LOL{i})*load_loss_table(i)))
    
end

LOEE_final=repmat(0,N,1)
LOL_final=repmat(0,N,1)

for i=1:length(failure_rates)
    LOEE_final=LOEE_final+sum(LOEE{i},2)
    LOL_final=LOL_final+sum(LOL{i},2)
end
LOLE_final=LOEE_final./LOL_final
LOLE_final(isnan(LOLE_final))=0;
%% Checking for Convergence
conv_LOEE=cumsum(LOEE_final)./[1:1:N]'
conv_LOLE=cumsum(LOLE_final)./[1:1:N]'






    
    
    
    
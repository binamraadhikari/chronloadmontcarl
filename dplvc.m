%% Horly Load Curve
%Author: Binamra Adhikari
%University of Saskatchewan

%Assumption: Weekends and Weekdays have same hourly profiles throughout the
%day

close all; clear all;
%Weekly Peak Load as a Percentage of Annual Peak
wpl=[
    86.2
    90
    87.8
    83.4
    88
    84.1
    83.2
    80.6
    74
    73.7
    71.5
    72.7
    70.4
    75
    72.1
    80
    75.4
    83.7
    87
    88
    85.6
    81.1
    90
    88.7
    89.6
    86.1
    75.5
    81.6
    80.1
    88
    72.2
    77.6
    80
    72.9
    72.6
    70.5
    78
    69.5
    72.4
    72.4
    74.3
    74.4
    80
    88.1
    88.5
    90.9
    94
    89
    94.2
    97
    100
    95.2
    ];
    
%Daily Peak Load as a Percentage of Weekly Peak
dpl=[
    93
    100
    98
    96
    94
    77
    75
    ];

%Hourly Peak Load as a Percentage of Daily Peak
hpl=[
67	78	64	74	63	75
63	72	60	70	62	73
60	68	58	66	60	69
59	66	56	65	58	66
59	64	56	64	59	65
60	65	58	62	65	65
74	66	64	62	72	68
86	70	76	66	85	74
95	80	87	81	95	83
96	88	95	86	99	89
96	90	99	91	100	92
95	91	100	93	99	94
95	90	99	93	93	91
95	88	100	92	92	90
93	87	100	91	90	90
94	87	97	91	88	86
99	91	96	92	90	85
100	100	96	94	92	88
100	99	93	95	96	92
96	97	92	95	98	100
91	94	92	100	96	97
83	92	93	93	90	95
73	87	87	88	80	90
63	81	72	80	70	85
];
peakload=1; %Modify as per need (In MW)
dpl=dpl*0.01
wpl=wpl*0.01
hpl=hpl*0.01

i=1

%% For obtaining Yearly Peak Load Variation
for week=1:52
    for day=1:7
        dplvc_data(i)=wpl(week)*dpl(day)*peakload
        i=i+1
    end
end



%% For obtaining Hourly Load Variation throughout the year
hourly_profile=[]
for day=1:56
    %Winter Weeks
    hour=repmat(dplvc_data(day),24,1)
    hourly_profile=[hourly_profile; hour.*hpl(:,1)]
end
for day=57:119
    %Spring and Fall Weeks
    hour=repmat(dplvc_data(day),24,1)
    hourly_profile=[hourly_profile; hour.*hpl(:,5)]
end
for day=120:210
    %Summer Weeks
    hour=repmat(dplvc_data(day),24,1)
    hourly_profile=[hourly_profile; hour.*hpl(:,3)]
end
for day=211:301
    %Spring and Fall Weeks
    hour=repmat(dplvc_data(day),24,1)
    hourly_profile=[hourly_profile; hour.*hpl(:,5)]
end
for day=302:364
    %Winter Weeks
    hour=repmat(dplvc_data(day),24,1)
    hourly_profile=[hourly_profile; hour.*hpl(:,1)]
end

hourly_profile(8736:8760)=hourly_profile(end-24:end) %Assuming the last day also has the same profile as the previous day



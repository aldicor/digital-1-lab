ttl = readtable("TTL.csv");
ttl = ttl(6:end,1:3);
ttl = table2array(ttl);

%%
figure(1)

plot(ttl(1:length(ttl)/2,1),ttl(1:length(ttl)/2,2));
hold on 
plot(ttl(1:length(ttl)/2,1),ttl(1:length(ttl)/2,3));

legend('V_{in}','V_{out}')
xlabel('t(\mu S)')
ylabel('V(V)')

hold off

%%

scatter(ttl(1:end,2),ttl(1:end,3));
xlabel('V_{in} (V)')
ylabel('V_{out} (V)')

%% tiempos

temp = ttl(50:180,:);

t  = temp(1:end,1);
v1 = temp(1:end,2);
v2 = temp(1:end,3);

plot(t,v1);

hold on

plot(t,v2);
legend('V_{in}','V_{out}')
xlabel('t(\mu S)')
ylabel('V(V)')

hold off

%% signal processing t fall tphl
t2  = resample(t,200,1);

v1 = interp1(t,v1,t2);
v2 = interp1(t,v2,t2);


scatter(t2,v1);

hold on

scatter(t2,v2);
legend('V_{in}','V_{out}')
xlabel('t(\mu S)')
ylabel('V(V)')

hold off

%% signal processing t fall tplh

temp = ttl(800:900,:);

t  = temp(1:end,1);
v1 = temp(1:end,2);
v2 = temp(1:end,3);

t2  = resample(t,200,1);

v1 = interp1(t,v1,t2);
v2 = interp1(t,v2,t2);


scatter(t2,v1);

hold on

scatter(t2,v2);
legend('V_{in}','V_{out}')
xlabel('t(\mu S)')
ylabel('V(V)')

hold off


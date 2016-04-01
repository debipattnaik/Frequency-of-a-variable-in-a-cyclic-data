num=xlsread('C:\Users\ppxdpp\Desktop\0.xlsx'); % path to read the data from
x=num(:,1);lx=length(x); %divides into x and y coloumns
%x=sort(x1)
y=num(:,4);bx=[];dx=[];by=[];dy=[];
%[xg,yg] = consolidator13(x,y,'mean');
%[xg,yg]
[xg1,yg1] = consolidator13(x,y,'count');% gives the count of each repated field value.
[xg1,yg1];
count=yg1(1);
disp('number of cycles=');
nc=count/2;count_cycle=lx/nc;
disp(count/2);
disp('number of values in each cycle:');
disp(count_cycle);half=count_cycle/2;
ax=x(1:half,:);
ay=y(1:half,:);
cx=x(half+1:count_cycle,:);
cy=y(half+1:count_cycle,:);
i=1;
while i<count
    if (i*(count_cycle)+half)<lx
bx=[bx; x(i*(count_cycle)+1:(i*count_cycle)+half)];
by=[by; y(i*(count_cycle)+1:(i*count_cycle)+half)];
    end

i=i+1;
end
upsweepx=[ax;bx]; 
upsweepy=[ay;by];
upsweep=[upsweepx upsweepy];
disp('the up sweep is');
disp(upsweep);



size(upsweep)
j=1;
while j<count
    if (j*count_cycle)+2*half<=lx
   dx=[dx; x((j*count_cycle)+half+1:(j*count_cycle)+(2*half))];
    dy=[dy; y((j*count_cycle)+half+1:(j*count_cycle)+(2*half))];
    end
   j=j+1;
end
downsweepx=[cx;dx];
downsweepy=[cy;dy];
downsweep=[downsweepx downsweepy];
disp('the down sweep is');
disp(downsweep);
size(downsweep);
[xg_up,yg_up] = consolidator13(upsweepx,upsweepy,'mean');
up=[xg_up,yg_up];
disp('the averaged upsweep is');
up=[xg_up,yg_up];
disp(up);
[xg_down,yg_down] = consolidator13(downsweepx,downsweepy,'mean');
down=[xg_down,yg_down];
disp('the averaged down sweep is');
disp(down);
%this array must be flipped in decreasing order wrt to 1st coloumn to have a
%hysteresis graph with no straight line connecting initial and final
%points.
down_flip=flipdim(down,1); %Flips the down sweep in reverse order so we get a continuous cycle of points.
disp('the average hysteresis loop data is');
avg_loop=[up;down_flip]
plot(avg_loop(:,1),avg_loop(:,2),'r');
title('Graph of Kerr angle wrt to voltage to electromagnet')
xlabel('voltage');
ylabel('theta');
filename=('C:\Users\ppxdpp\Desktop\data from matlab.xlsx'); %exporting data to excel spreadsheet. Change as per your file location you wish to
xlswrite(filename,avg_loop);

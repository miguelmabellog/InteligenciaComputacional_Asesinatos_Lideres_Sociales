opt = anfisOptions('InitialFIS',6,'EpochNumber',1000);

xx=(1:384);
x=xx';
data=[xx;as'];
data=data';
a = 1;
b = 384;
kk=58;
r=zeros(58,1);
valid=zeros(58,2);
k= round((b-a).*rand(1000,1) + a);
for v = 1:1:58
    r(v,:)=k(v,:);
end


for v = 1:1:58
    for vv = 1:1:58
        if v~=vv && r(v,:)==r(vv,:)
            while k(v+kk,:)==r(v,:)
                kk=kk+1;
            end
            r(v,:)=k(v+kk,:);
            kk=58;
        end
                
    end
end
validando=1;
for v = 1:1:58
    for vv = 1:1:58
        if v~=vv && r(v,:)==r(vv,:)
            disp(v)
            disp(vv)
            validando=0;
        end
                
    end
end

for v = 1:1:58
    valid(v,:)=data(r(v,:),:);
end
traindata=zeros(326,2);
cuente=0;
sum=1;


for vvv=1:1:384
    for vv=1:1:58
        if(data(vvv,:)==valid(vv,:))
            cuente=cuente+1;
        end
    end
    if(cuente==0)
        traindata(sum,:)=data(vvv,:);
        sum=sum+1;
    end
    cuente=0;
    
end

if validando==1
    opt.ValidationData = valid;
    [fis,trainError,stepSize,chkFIS,chkError] = anfis(traindata,opt);
    anfisOutput = evalfis(fis,xx);
    plot(x,data(:,2),'*r',x,anfisOutput,'.b')
    legend('Training Data','ANFIS Output','Location','NorthWest')
    figure
    plot((1:size(trainError)),trainError)
    hold on 
    plot((1:size(chkError)),chkError)
    legend('error entrenamiento','error generalización','Location','NorthWest')
end


%[fis,trainError] = anfis(data,opt);
%anfisOutput = evalfis(fis,xx);
%plot(x,data(:,2),'*r',x,anfisOutput,'.b')
%legend('Training Data','ANFIS Output','Location','NorthWest')
%figure
%plot((1:size(trainError)),trainError)
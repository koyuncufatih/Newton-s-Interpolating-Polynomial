% created by Fatih Koyuncu
% fatihkoyuncu99@gmail.com
function [realresult] = NewtonsInterpolating(datax,y,xat,order)
    function d2 = d2(a,b)
       ia=find(datax==a);
       ib=find(datax==b);
       datax(ia)-datax(ib);
       y(ia)-y(ib);
       d2=(y(ia)-y(ib))/(a-b);
    end

len=length(datax);
ay=datax;
if order>=len
    error="ERROR"
else
       
dy=abs(ay-xat);
sortdy=sort(dy);
j=1;
    for i=1:order+1
        [row,col]=find(dy==sortdy(i));
        if length(col)>1
        value(i)=datax(col(j));
        j=j+1;
        if j==length(col)+1
            j=1;
        end
        else
        value(i)=datax(col);
        end
    end
value=sort(value,'descend');
lenvalue=length(value);


    for i=1:length(value)-1
        result(1,i)=d2(value(i),value(i+1));
    end
    
    for j=1:length(value)-2
        for i=1:length(result)-j
            result(j+1,i)=(result(j,i)-result(j,i+1))/(value(i)-value(i+j+1));
        end
    end        
     ix0=find(datax==value(lenvalue));
     
       diff=xat-value(2:end);
       realresult=y(ix0);
       product=1;

        for i=0:order-1
            realresult=realresult+(product*diff(end-i))*result(i+1,end-i);
            product=product*diff(end-i);
        end
end
end


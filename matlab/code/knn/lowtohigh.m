function y=lowtohigh(a,l)     %起泡法由小到大排序
for i=1:l
    for j=1:l
        if(a(i)<a(j))
                temp=a(i);
                a(i)=a(j);
                a(j)=temp;
        end
        %j=j+1;
    end
    %i=i+1;
end
y=a;

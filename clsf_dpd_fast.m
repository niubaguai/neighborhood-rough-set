%程序描述：clsf_dpd_fast,计算新加入的一个属性的依赖度(no,no,yes)-----------新思想+我的改进1
%5种情况：（每次是否检查全部样本、邻域样本是否全部检查、距离是否计算完）=>(yes，yes,yes)+(no，yes,yes)+(no，yes,n
%o)+(no,no,yes)+(no,no,no)
%邻域计算复杂度有两种，这里用的旧的：边界上的样本认为会全部分错
%data_array：标准化之后的数据,数组，列表示一个属性(包括决策属性)在不同样本上的取值，行表示一个样本在不同属性上的取值
%delta：邻域大小,固定值
%smp_chk:需判断类别的样本编号，新加入的属性只对这些样本有作用，因此计算的是新加入属性的依赖度
function [dependency,smp_csst]=clsf_dpd_fast(data_array,delta,smp_chk)
[m,n]=size(data_array);
num_rightclassified=0;
smp_csst=[];
for i=1:length(smp_chk) %smp_chk 样本的个数
    %对于第i个样本，在某一个属性下,找到它的邻域
    sign=1;
    j=0;
    while j~=m
        j=j+1;
        sqare_distance=0;
        if j~=i        
            for k=1:n-1   
                d=(data_array(smp_chk(i),k)-data_array(j,k))^2;%是否支持符号型数据(自然数)，区别在此
                if d>1
                    sqare_distance=sqare_distance+1;
                else
                    sqare_distance=sqare_distance+d;
                end
            end
            if sqrt(sqare_distance)<=delta
                if data_array(j,n)~=data_array(smp_chk(i),n)
                    j=m;
                    sign=0;
                end
            end
        end
    end
    if sign==1
        num_rightclassified=num_rightclassified+1;
        smp_csst=[smp_csst,smp_chk(i)];
    end
end
dependency=num_rightclassified/m;

            
            
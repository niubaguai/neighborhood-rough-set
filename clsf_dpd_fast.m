%����������clsf_dpd_fast,�����¼����һ�����Ե�������(no,no,yes)-----------��˼��+�ҵĸĽ�1
%5���������ÿ���Ƿ���ȫ�����������������Ƿ�ȫ����顢�����Ƿ�����꣩=>(yes��yes,yes)+(no��yes,yes)+(no��yes,n
%o)+(no,no,yes)+(no,no,no)
%������㸴�Ӷ������֣������õľɵģ��߽��ϵ�������Ϊ��ȫ���ִ�
%data_array����׼��֮�������,���飬�б�ʾһ������(������������)�ڲ�ͬ�����ϵ�ȡֵ���б�ʾһ�������ڲ�ͬ�����ϵ�ȡֵ
%delta�������С,�̶�ֵ
%smp_chk:���ж�����������ţ��¼��������ֻ����Щ���������ã���˼�������¼������Ե�������
function [dependency,smp_csst]=clsf_dpd_fast(data_array,delta,smp_chk)
[m,n]=size(data_array);
num_rightclassified=0;
smp_csst=[];
for i=1:length(smp_chk) %smp_chk �����ĸ���
    %���ڵ�i����������ĳһ��������,�ҵ���������
    sign=1;
    j=0;
    while j~=m
        j=j+1;
        sqare_distance=0;
        if j~=i        
            for k=1:n-1   
                d=(data_array(smp_chk(i),k)-data_array(j,k))^2;%�Ƿ�֧�ַ���������(��Ȼ��)�������ڴ�
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

            
            
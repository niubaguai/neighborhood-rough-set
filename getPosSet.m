function PosSet = getPosSet(dataArray,lammda)
% ������ֲڼ��㷨�ķ�ʽ��ȡ�½���
% ����dataArrayΪ�����������Ե��������������һ��Ϊ��������
% lammdaΪ����뾶���ϼ���ʱ��Ĳ��� delta=std��data��/lammda
% lammda ע�⣡����������lammda�ͺ��廪�����lammda������
% ����lammdaȡֵ������0.5~1.5֮�䣬���̫���������������������̫С������򱨴�
% ��������ڰ������������Ƚ϶ࣨ��ʮ���ϣ��������lammda=2~4
% �����PosSetΪ���򼯺�
% made by suozi 20140427
% QQ��379786867

[m,n]=size(dataArray); % mΪ������ nΪ���Ը���(���һ��Ϊ��������)
if m<3 && n<3
    disp('����ľ���ϵͳ���и�������С��3����');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���ȶ����ݽ��й�һ��
for j=1:n-1
    amin=min(dataArray(:,j));
    amax=max(dataArray(:,j));
    for i=1:m
        dataArray(i,j)=(dataArray(i,j)-amin)./(amax-amin);
    end
end
% ��ʱ�õ�����������Ϊ��һ���������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��������뾶
%delta=std(dataArray)/lammda; %�������һ�еľ������Ե�����뾶û���õ�
delta=lammda;
condiAtt=dataArray(:,1:n-1); % �������Լ���
decsAtt=dataArray(:,n); % �������Լ���

NbrSet=[]; % ������򼯺�
Nbr_tmp=[];% ���ÿ����������ʱ�������򼯺�
PosSet_tmp=[];
flag2=1;

%%%%%%%%%%%%%%%%% ���������������Ե����򼯺�
for i=1:m
   Nbr_tmp=[];% �ÿմ���
   for j=1:m
       flag1=1; % �Ƿ�д�����򼯺ϵ��жϱ�� 1����д�� 0������д��
       dist=abs(condiAtt(i,1)-condiAtt(j,1)); % �������
       if dist<=delta % ���Ӧ�ĵ�һ�е�1�е�����뾶���Ա�
           for k=2:n-1 % �������Եı����ж�
              dist_tmp = abs(condiAtt(i,k)-condiAtt(j,k)); % �����Ӧ�����������ڲ�ͬ�����¾����Ƿ������Ӧ��Ҫ��
              if dist_tmp<=delta % ��Ӧ�ĵ�k�����Ե�����뾶
                  flag1=1; % �Ƿ�д�����򼯺ϵ��жϱ�� 1����д�� 0������д��
              else
                  flag1=0;
                  break % ��������������ڶ�Ӧ����֮��ľ����������뾶�ˣ�������forѭ��
              end
           end
           if flag1==1 %����д�����򼯺� �� �õ����½��Ƶļ���
              Nbr_tmp=[Nbr_tmp,j]; % �õ����½��Ƽ���
              flag1=0;
           end
       end
   end
   NbrSet(i,(1:length(Nbr_tmp)))=Nbr_tmp; % ��������������Ե����е����򼯺�
   % ���ڸþ����У�ÿ���ڴ�ŵĶ��Ƕ�Ӧ�����������򼯺�
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% ����������ԵĻ������
for p=1:m
    NbrD_tmp=[]; %���
   for q=1:m
      if decsAtt(p,1)==decsAtt(q,1)
          NbrD_tmp=[NbrD_tmp,q];
      end
   end
   NbrD_Set(p,(1:length(NbrD_tmp)))=NbrD_tmp; % ��ž������ԵĻ������
end


%%%%%%%%%%%%%%%%%%%%%%%%%% �����������)
for r=1:m %�����ó���ÿ�����������򼯺�
    tmp=NbrSet(r,:); %ȡ����r�е��½��Ƽ��ϣ����ܰ���0���֣�
    for t=1:length(tmp)
        if tmp(1,t)~=0 % �ų�Ϊ0�����
            sign=ismember(tmp(1,t),NbrD_Set(r,:)); %��������е�Ԫ�أ��򷵻�sign=1��������Ϊ0; ismember(a,b)���������Ҫ�ǿ�����a�е����ǲ��Ǿ���b�еĳ�Ա���ǵĻ��������1�����Ƿ���0
        end
        if sign==1 %�����е�Ԫ��
            flag2=1;
        else
            flag2=0;
            break % �������ֱ������ѭ����֤�����鼯��Ԫ�ز��Ǿ��߶�Ӧ���ϵ��Ӽ�
        end
    end
    if flag2==1
        PosSet_tmp(r,(1:length(tmp)))=tmp; %��Ż�����
    end
end

%%%%%%%%%%%%%%%%%%%%%%% ����ó�����
PosSet=[];% ������򼯺�
for s=1:length(PosSet_tmp) % ������ʱ�õ�������
   posTmp=PosSet_tmp(s,:);
   flag3=1;
   for z=1:length(posTmp)
       flag3=1;
       if posTmp(1,z)~=0 % �޳�0��Ԫ��
          flag3=ismember(posTmp(1,z),PosSet); %�жϵ�ǰԪ���Ƿ��Ѿ������������� 
       end
       if flag3==0 %��������뵽���򼯺���
           PosSet=[PosSet,posTmp(1,z)];
       end
   end
end




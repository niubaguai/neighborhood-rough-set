% ��
clc;
clear;
% ��������
%data_array = load('testData.mat');
%data_array=data_array.unnamed;
data_array = load('wine.mat');
data_array=data_array.standdata;

% mΪ��������nΪ������
[m,n]=size(data_array);
sig_ctrl=0.01; %��Ҫ�����޵Ŀ��Ʋ�����ȡ�ӽ�0����
delta=0.1; %����뾶
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
feature_slct=[]; % ��������ѡ��ļ���
feature_lft=(1:n-1); % ��������
condiAtt=data_array(:,1:n-1); % �������Լ���
decsAtt=data_array(:,n); % �������Լ���
NbrSet=[]; % ������򼯺�
Nbr_tmp=[];% ���ÿ����������ʱ�������򼯺�

red=[]; % ��ʼ��Լ�������Ӽ�����ʼֵΪ��
red_dpd=0; % ��ʼ��Լ�򼯺ϵ������ȣ���ʼֵΪ0

num_cur=0;
array_cur=[];
while num_cur<n-1 
    if num_cur==0
        array_cur=[];
    else
        array_cur(:,num_cur)=data_array(:,feature_slct(num_cur));%����ѡ�е����Զ�Ӧ�����мӵ�ԭ�б���
    end
    
    %%%%%%%%%%%%%%%%%%
    %%%%  ��ÿ�������Լ���������
    %%%%%%%%%%%%%%%%%%%
    for i=1:length(feature_lft)  % feature_lft ���Եĸ���
        array_tmp=array_cur;
        % ѡ�������ԣ�����Ѿ�ȷ����һ��Լ����������������һ��ϳ�������
        array_tmp(:,[num_cur+1,num_cur+2])=data_array(:,[feature_lft(i),n]);% ѡ����i���������������  ��ͨ��feature
        % ��ʱ�õ��ľ���ϵͳΪȥ����ָ�����������Ե��µľ���ϵͳ
        PosSet_Att=getPosSet(array_tmp,delta); %�����������
        % ����������
        dpd_Att_tmp=length(PosSet_Att)/m; % ����ÿ�����Ե�������
        dpd_Atti(i,1)=dpd_Att_tmp; % ��ÿ�����Ե������ȴ洢����,��g��
        % ������Ҫ��
        sig_Att_tmp=dpd_Att_tmp-red_dpd; % ����ÿ�����Ե���Ҫ�ȣ����ӷ�������ɾ����
        sig_Att(i,1)=sig_Att_tmp; % ��ÿ�����Ե���Ҫ�ȴ洢��������g��
        
    end
    % ѡ����Ҫ������һ��������������
    [max_sig,max_sequence1]=max(sig_Att);%max_dpd��ʾÿ������ֵ��max_sequence1��ʾ�������ֵ���ڵ���
    red_dpd=red_dpd+max_sig
    sig_Att=[]; % �����Ҫ������
    % �жϣ����������Ҫ��Ϊ0�Ļ�������Լ���㷨
    if max_sig==0
        break
    end
    feature_slct(num_cur+1)=feature_lft(max_sequence1);    % ��������ѡ��ļ���
    feature_lft(max_sequence1)=[]; % ��max_sequence1����ɾ��
    
    num_cur=num_cur+1;
end

feature_slct










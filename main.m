% ��
clc;
clear;
% ��������
data_array = load('testData.mat');
data_array=data_array.unnamed;
% �������
% delta�Ǻ�������������������ֵ������һ������������ʹ���Ż��㷨��ѡȡ�������ȹ̶�����ɢ�����ݣ�0�����������ݣ�0.1
delta = 0  % ������ɢ������

[m,n]=size(data_array); % m��ʾ��������n��ʾ������
feature_lft=(1:n-1); %feature_lft��ʾ��������
sample_lft=(1:m); %sample_lft��ʾѡ�������
array_cur=[] %
%neiborghood_array = zeros(m,m,3) % ����һ����ά����
neiborghood_temp = [] % ��ʱ���������
neiborghood_array = [] % ���ĳ�������µ�������

% ��ÿ��������
for f=1:length(feature_lft)
    for i=1:length(sample_lft)
        xi=data_array(i, f) % xi����ÿ��ѡ��f���Ե� ��i��������ע��������
        for j=1:length(sample_lft)
            xj=data_array(j, f)
            % ��������������ͬһ�������µľ���
            % ʹ�ö���õĺ���
            dist = dist_E(xi,xj)
            if dist<=delta
                neiborghood_temp = [neiborghood_temp, j] % �����࣬��һ�������µ�һ��������������
            end
        end
        neiborghood_array = [neiborghood_array; neiborghood_temp] % ����µ�һ��
        neiborghood_temp = [] % ���
    end
    % ���
    neiborghood_array = []
    % ����������
end


% 1������ÿ��������������

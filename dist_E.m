function dist = dist_E(x,y)
[m,n] = size(x);
dist = 0;
for i=1:max(m,n)
    dist = dist+(x(i)-y(i))^2;
end
dist = sqrt(dist);
end


function [l1,l2,v1,v2,v3,v4] = eigen2d_m(a,b,c,d)

%% matlab version
l1 = zeros(size(a));
l2 = zeros(size(a));
v1 = zeros(size(a));
v2 = zeros(size(a));
v3 = zeros(size(a));
v4 = zeros(size(a));

for i=1:size(a,1)
    for j=1:size(a,2)
        [v,l] = eig([a(i,j) b(i,j); c(i,j) d(i,j)]);
        l1(i,j) = l(1,1);
        l2(i,j) = l(2,2);
        v1(i,j) = v(1,1);
        v2(i,j) = v(2,1);
        v3(i,j) = v(1,2);
        v4(i,j) = v(2,2);
    end
end

end
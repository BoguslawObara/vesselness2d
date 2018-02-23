function [l1,l2] = eigen2d(a,b,c,d)
%% an analytic solution for the eigenvalues of 2x2 matrices.

%% help: 
% http://en.wikipedia.org/wiki/Eigenvalue_algorithm
% http://www.math.harvard.edu/archive/21b_fall_04/exhibits/2dmatrices/index.html
%
%     | a  b |
% A = |      |
%     | c  d |
%

%% eigenvalues
% lambda = (a+d)/2 +- sqrt( (a+d)^2/4 + bc - ad )
l1 = (a + d)/2 + sqrt( (a + d).^2/4 + b.*c - a.*d );
l2 = (a + d)/2 - sqrt( (a + d).^2/4 + b.*c - a.*d );

%% sort eigenvalues -> |lambda1| <= |lambda2|
index = abs(l1)>abs(l2);

ls1 = l1; 
ls2 = l2;

ls1(index) = l2(index);
ls2(index) = l1(index);

l1 = ls1;
l2 = ls2;

%% TODO - eigenvectors
% if c is not zero, then the eigenvectors are:
% | l1-d |   | l2-d |
% |      | , |      |
% |   c  |   |   c  |
% if b is not zero, then the eigenvectors are
% |   b  |   |   b  |
% |      | , |      |
% | l1-a |   | l2-a |
% if both b and c are zero, then the eigenvectors are
% |   1  |   |   0  |
% |      | , |      |
% |   0  |   |   1  |

%% 
% vx = L1-d; %L1-L2
% vy = b;

%% normalize the magnitudes of the eigenvectors by dividing by its length
% m = sqrt( vx.^2 + vy.^2 );
% m(m==0) = eps;
% vx = vx./m; 
% vy = vy./m;

end
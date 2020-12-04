function MS = magicCube(N, rx, ry, rz)
% N - order of the psuedo magic cube
% rx, ry, rz - rolling axes

MS = zeros(N, N, N);
for i = 1:N
    for j = 1:N
        for k = 1:N
            
            a = mod(i+rx-j-ry+k+rz-1,N);
            b = mod(i+rx-j-ry-k-rz,N);
            c = mod(i+rx+j+ry+k+rz-2,N);
            
            MS(i,j,k) = a*N^2 + b*N+ c;
            
        end
    end
end

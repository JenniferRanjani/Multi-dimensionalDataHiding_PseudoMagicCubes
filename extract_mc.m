function recover = extract_mc(steg, sz, N, seed, rx, ry, rz)

[row,col] = size(steg);

%Random sequence generated using the random seed.
s = RandStream('mt19937ar','Seed',seed);
Q=randperm(s,row*col);

%Extraction Algorithm
ind = 1;
recover = zeros(1,sz);
for x = 1: sz
   i = steg(Q(ind));
    j = steg(Q(ind+1));
    k = steg(Q(ind+2));
    ind = ind + 3;
    
    a = mod(i+rx-j-ry+k+rz-1,N);
    b = mod(i+rx-j-ry-k-rz,N);
    c = mod(i+rx+j+ry+k+rz-2,N);
            
    G=a*N^2 + b*N+ c ;
    
    recover(x) = G;
    
end

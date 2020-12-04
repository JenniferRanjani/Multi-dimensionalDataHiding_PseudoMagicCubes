function steg = embed_mc(I, msg, N, seed,rx,ry,rz)
[row,col] = size(I);
sz = size(msg,2);

%Generate the Pseudo Magic Cube of order N
MC = magicCube(N, rx, ry, rz);

%Random sequence generated using the random seed.
s = RandStream('mt19937ar','Seed',seed);
Q=randperm(s,row*col);

%Embedding Algorithm
cn=ceil(N/2);
fn=floor(N/2);

ind = 1;
for x = 1: sz
    
    i = I(Q(ind));
    j = I(Q(ind+1));
    k = I(Q(ind+2));
    
    
    a = mod(i+rx-j-ry+k+rz-1,N);
    b = mod(i+rx-j-ry-k-rz,N);
    c = mod(i+rx+j+ry+k+rz-2,N);
            
    G=a*N^2 + b*N+ c;
    
    sd = msg(x);
            
    ms_ind=find(MC(:)==G);
    [xms,yms,zms] = ind2sub([N,N,N],ms_ind);
     
    sd_ind = find(MC(:)==sd);
    [xsd,ysd,zsd] = ind2sub([N,N,N],sd_ind);
     
    xd = xsd-xms;
    yd = ysd-yms;
    zd = zsd-zms; 
    
    xm=xd.*(abs(xd)<cn)+mod(xd,N).*(xd<-fn)+(mod(xd,N)-N).*(xd>fn);
    ym=yd.*(abs(yd)<cn)+mod(yd,N).*(yd<-fn)+(mod(yd,N)-N).*(yd>fn);
    zm=zd.*(abs(zd)<cn)+mod(zd,N).*(zd<-fn)+(mod(zd,N)-N).*(zd>fn);
    
    xc = i+xm;
    yc = j+ym;
    zc = k+zm;
    
    I(Q(ind))= xc;
    I(Q(ind+1)) = yc;
    I(Q(ind+2)) = zc;
    ind = ind + 3;
end
steg = I;

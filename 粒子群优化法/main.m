figure(1);
subplot(1,2,1);
[X,Y]=meshgrid(-2:0.1:2);
Z=100*(Y-X.^2).^2+(ones(size(X))-X).^2;
surf(X,Y,Z)
subplot(1,3,3);


for i=1:1
m(i)=PSO(f,2,200,500,0.9,0.2,0.2);
end
disp(mean(m));
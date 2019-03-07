function [m] = PSO(f,N,P,Kmax,w,c1,c2)
% f : la fonction
% N : le degr¨¦ de libert¨¦
% P : le nombre de points
% Kmax : le temps qui se passe
% m : nombre d'it¨¦rations
m=0;

% cr¨¦er E0
for p=1:P
    for i=1:N
         x(p,i)=randn;
         v(p,i)=randn;
    end
end

% Vmax = ? (selon f)
% Xmax = ?
Vmax=5;
xB=-5;
xA=5;

% fI(p) : la valeur mininale de f de p ¨¨me point
% xI(p) : la meilleure solution de p ¨¨me point
for p=1:P
    fI(p)=f(x(p,:));
	xI(p,:)=x(p,:);
end

% xG : La meilleure solution obtenue dans son voisinage
xG=x(1,:);
for p=2:P
    if f(x(p,:)) < f(xG)
        xG=x(p,:);
    end
end


for k=0:Kmax
    w=0.9-k*(0.9-0.4)/Kmax;
    %plot
    pause(0.1);
    figure(1);
    set (gcf,'Position',[232,246,1020,420], 'color','w')
    subplot(1,2,1);
    scatter(xI(:,1),xI(:,2));
    subplot(1,2,2);
    [X,Y]=meshgrid(-2:0.1:2);
    Z=100*(Y-X.^2).^2+(ones(size(X))-X).^2;
    surf(X,Y,Z,'FaceAlpha',0.5,'EdgeColor','none')
    hold on
    scatter3(xI(:,1),xI(:,2),fI','.');
    hold off
    for p=1:P
        % mise ¨¤ jour de vitesse(v) et position(x)
        v(p,:)=w*v(p,:)+c1*rand*(xI(p,:)-x(p,:))+c2*rand*(xG-x(p,:)); 
        %  Contraintes de bornes : 	v = max{Vmax, min{-Vmax,v}}	
		for i=1:N
			if v(p,i)>Vmax
				v(p,i)=Vmax;
			elseif v(p,i)<-Vmax
				v(p,i)=-Vmax;
			end		
        end

        x(p,:)=x(p,:)+v(p,:);
        %  Contraintes de bornes : 	x = max{xA, min{xB,x}}
        for i=1:N
			if x(p,i)>xA
				x(p,i)=xA;
			elseif x(p,i)<xB
				x(p,i)=xB;
			end		
		end
        % mise ¨¤ jour de fI(p) et xI(p)
        if f(x(p,:)) < fI(p)
            fI(p)=f(x(p,:));
            xI(p,:)=x(p,:);
        end
        % mise ¨¤ jour de xG
        if  fI(p)< f(xG)
            xG=xI(p,:);
        end
    end
    m=k+1;
    
    % si la norme de x(k+1) - x(k) est inf¨¦rieur ¨¤ 1% de la norme de x(k)
	if norm(v)/norm(x)<0.01
        break
    end

end

% disp('--------------------------------------')  
% disp(m);
  
clear all
close all
clc

nodes(1:100,1:100) = -10;
winner(1:100,1:100) = -10;
step(1:100,1:100) = '-';

m1 = 'Please enter the distance between of the 2 players!:';
A = input(m1);
m2 = 'Please enter the size of the big step D:';
D = input(m2);
m3 = 'Please enter the size of the small step d:';
d = input(m3);

n = ceil(A/d + 1); % Defining the depth of each matrix
nodes(1,1) = A; % Setting the 1st entry of the array to the distance between of the 2 players

for i=2:1:n                                 % For each level of the tree
    for j=1:1:n                             % For each node on each level of the tree
        if(nodes(i-1,j) ~= -10)             % Checking if the node is not -1
            nodes(i,j) = nodes(i-1,j)-D;    % Value of distance after a big step
            nodes(i,j+1) = nodes(i-1,j)-d;  % Value of distance after a small step
        end
    end
end
nodes(1:n,1:n)

for i=n:-1:1
    for j=n:-1:1
        if mod(i,2)==1 % For levels 1,3,5,7,9,...
            if nodes(i,j)<=0
                if nodes(i,j)~=-10 & nodes(i,j)>-5
                    winner(i,j) = 1; % Player 1 wins!
                end
            else
                if winner(i+1,j)<0 | winner(i+1,j+1)<0
                    winner(i,j) = 2; % Player 2 wins!
                elseif winner(i+1,j)>0 & winner(i+1,j+1)>0
                    winner(i,j) = 1; % Player 1 wins!
                end
            end
        else % For levels 2,4,6,8,10,...
            if nodes(i,j)<=0
                if nodes(i,j)~=-10 & nodes(i,j)>-D
                    winner(i,j) = 2; % Player 2 wins!
                end
            else
                if winner(i+1,j)>0 | winner(i+1,j+1)>0
                    winner(i,j) = 1; % Player 1 wins
                elseif winner(i+1,j)<0 & winner(i+1,j+1)<0
                    winner(i,j) = 2;
                end
            end
        end
    end
end
winner(1:n,1:n)

for i=1:1:n
    for j=1:1:n
        if mod(i,2)==1
            if winner(i,j)==1 % >0 Player 1
                step(i,j) = 'd';
            else
                if winner(i,j)==-10
                    step(i,j) = '-';
                elseif winner(i+1,j)==2 % <0 Player 2
                    step(i,j) = 'D';
                else
                    step(i,j) = 'd';
                end
            end
        else
            if winner(i,j)==1 % >0 Player 1
                if winner(i+1,j)==1 % >0 Player 1
                    step(i,j) = 'D';
                else
                    step(i,j) = 'd';
                end
            else
                if winner(i,j)==-10
                    step(i,j) = '-';
                else
                    step(i,j) = 'd';
                end
            end
        end
    end
end
step(1:n,1:n)

for i=1:1:n
    if mod(i,2)==1
        player = 1;
    else
        player = 2;
    end
    Level = sprintf('%d - Plays the player: %d', i, player)
    for j=1:1:n
        if nodes(i,j)~=-1 & nodes(i,j)>-D
            Node_Distance = sprintf('%d, Optimal Step:%c', nodes(i,j), step(i,j))
        end
    end
end
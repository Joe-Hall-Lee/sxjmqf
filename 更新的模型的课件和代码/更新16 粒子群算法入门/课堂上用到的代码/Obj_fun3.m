function y = Obj_fun3(x)
% 注意，x 是一个向量
% Sphere 函数
% y = sum(x.^2); % x.^2 表示 x 中每一个元素分别计算平方

% Rosenbrock 函数
tem1 = x(1:end-1);
tem2 = x(2:end);
y = sum(100*(tem2 - tem1.^2).^2+(tem1 - 1).^2);

% Rastrigin 函数
% y = sum(x.^2-10*cos(2*pi*x)+10);

% Griewank 函数
% y = 1 / 4000 * sum(x.*x) - prod(cos(x./sqrt(1:30))) + 1;
end
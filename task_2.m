function [] = task_2()
    works = [12 14 15 16 23 36 37 45 47 56 58 67 68 78 89 99];
    conds = [
        23 12 6
        36 23 7
        37 23 7
        45 14 5
        47 14 5
        56 15 6
        56 45 9
        58 15 6
        58 45 9
        67 16 5
        67 36 5
        67 56 5
        68 16 5
        68 36 5
        68 56 5
        78 37 7
        78 47 7
        78 67 9
        89 78 7
        89 68 9
        89 58 7
        99 89 0
        ];
    x0 = ones(length(works) * 2 - 1, 1);
    lb = zeros(length(works) * 2 - 1, 1);
    
    fun = @(x) sum(x(1:length(works)));
    
    res = fmincon(fun, x0, [], [], [], [], lb, [], @funs);
    
    function [c, ceq] = funs(x)
        c = [];
        for i = 1:length(conds)
            t1 = find(works == conds(i, 1));
            t2 = find(works == conds(i, 2));
            q = conds(i, 3);
            m = length(works) + t2;
            c(end + 1) = -x(t1(1)) + x(t2(1)) + q / x(m);
        end
        c(end + 1) = sum(x(length(works) + 1:end)) - 0.75 * (length(works) - 1);
        ceq = 0;
    end

    t_res = res(1:length(works));
    m_res = res(length(works) + 1:end);
    sum_m_res = sum(m_res);

    disp(t_res);
    disp(m_res);
    disp(sum_m_res);
end
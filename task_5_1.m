function [] = task_5_1()
    times = [1 2 3 4 5 6 7 8 9];
    conds = [
        1 2 -6
        1 4 -5
        1 6 -5
        1 5 -6
        2 3 -7
        3 6 -5
        3 7 -7
        4 5 -9
        4 7 -7
        5 6 -5
        5 8 -7
        6 7 -9
        6 8 -9
        7 8 -7
        8 9 -8
    ];
    f = ones(length(times), 1);
    A = zeros(length(conds), length(times));
    b = zeros(1, length(conds));
    for i = 1:length(conds)
        t1 = find(times == conds(i, 1));
        t2 = find(times == conds(i, 2));
        A(i, t1) = 1;
        A(i, t2) = -1;
        b(1, i) = conds(i, 3);
    end

    lb = zeros(length(times), 1);

    t = linprog(f, A, b, [], [], lb);
    disp(t)
end
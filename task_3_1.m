function [] = task_3_1()
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
        99 89 8
        ];

    pairs = [
        12 14 6 5
        16 36 5 5
        56 36 5 5
        56 16 5 5
    ];
    cond_len = length(conds) + 2 * length(pairs);
    x_len = length(works) + 2 * length(pairs);
    f = ones(x_len, 1);
    f(length(works) + 1:end) = 0;
    A = zeros(cond_len, x_len);
    b = zeros(1, cond_len);
    for i = 1:length(conds)
        t1 = find(works == conds(i, 1));
        t2 = find(works == conds(i, 2));
        A(i, t1) = -1;
        A(i, t2) = 1;
        b(1, i) = -conds(i, 3);
    end

    Aeq = zeros(length(pairs), x_len);
    beq = ones(1, length(pairs));

    for i = 1:length(pairs)
        t1 = find(works == pairs(i, 1));
        t2 = find(works == pairs(i, 2));
        tau1 = pairs(i, 3);
        tau2 = pairs(i, 4);
        Y1 = length(works) + 2 * i - 1;
        Y2 = length(works) + 2 * i;
        M = 1000;

        idx = length(conds) + 2 * i - 1;
        A(idx, Y1) = -(M + tau2);
        A(idx, t1) = -1;
        A(idx, t2) = 1;
        b(1, idx) = -tau2;

        idx = idx + 1;
        A(idx, Y2) = -(M + tau1);
        A(idx, t1) = 1;
        A(idx, t2) = -1;
        b(1, idx) = -tau1;

        Aeq (i, Y1) = 1;
        Aeq (i, Y2) = 1;
    end

    lb = zeros(x_len, 1);

    x = intlinprog(f, (length(works) + 1):x_len, A, b, Aeq, beq, lb);

    disp(x)
end

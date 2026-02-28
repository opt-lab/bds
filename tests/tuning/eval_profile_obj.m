function fval = eval_profile_obj(x, plibs, mindim, maxdim)

    % Define parameters for both tuning and default solvers
    tune_params.expand = [x(1), 2.0];
    tune_params.shrink = [x(2), 0.5];
    
    % Configure options for the profiler
    options = struct();
    options.solver_names = {'cbds-tuning', 'cbds-default'};
    options.plibs = plibs;
    options.mindim = mindim;
    options.maxdim = maxdim;
    options.score_only = true;

    % Evaluate the plain feature
    options.feature_name = 'plain';
    scores_plain = tuning_optiprofiler(tune_params, options);
    ratio_plain = scores_plain(1) / scores_plain(2);

    % Evaluate the linearly transformed feature
    options.feature_name = 'linearly_transformed';
    scores_trans = tuning_optiprofiler(tune_params, options);
    ratio_trans = scores_trans(1) / scores_trans(2);

    % Return the objective value for minimization
    fval = -min(ratio_plain, ratio_trans);

end
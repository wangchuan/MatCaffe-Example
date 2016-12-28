function opt = config()

opt.solver_prototxt = './models/lenet_solver.prototxt';
opt.train_data_filename = './data/train.mat';
opt.valid_data_filename = './data/test.mat';

opt.max_epoches = 25;
opt.batch_size = 64;
opt.do_val = 1;

opt.display.progress = 1;
opt.display.visualize = 1;

if opt.display.visualize
    opt.output.acc_valid = [];
    opt.output.acc_train = [];
end

end
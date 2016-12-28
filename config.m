function opt = config()

opt.solver_prototxt = './models/cifar10_quick_solver.prototxt';
opt.train_data_filename = './data/cifar10/train.mat';
opt.valid_data_filename = './data/cifar10/test.mat';

opt.max_epoches = 150;
opt.batch_size = 100;
opt.do_val = 1;

opt.display.progress = 1;
opt.display.visualize = 1;

opt.output.dir = './outputs/cifar10/';
opt.output.acc_valid = [];
opt.output.acc_train = [];

end
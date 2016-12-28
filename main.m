clear; clc;

addpath('/home/cwang/caffe/matlab/');
addpath('./utils/');

opt = config();

caffe_init();

solver = caffe.Solver(opt.solver_prototxt);

train_dataset = load(opt.train_data_filename);
valid_dataset = load(opt.valid_data_filename);

do_train(train_dataset, valid_dataset, solver, opt);

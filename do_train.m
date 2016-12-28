function do_train(dataset, valid_dataset, solver, opt)

max_epoches = opt.max_epoches;
num_train_samples = length(dataset.labels);
batch_size = opt.batch_size;
num_batches = ceil(num_train_samples / batch_size);

if opt.display.progress
    progressbar('Total','Current Epoch');
end

for epoch = 1:max_epoches
    randidx = randperm(num_train_samples);
    data = dataset.data(:,:,:,randidx);
    labels = dataset.labels(randidx);
    for b = 1:num_batches
        s = (b - 1) * batch_size;
        batch = data(:,:,:,s+1:min(end,s+batch_size));
        label = labels(s+1:min(end,s+batch_size));
        batch = permute(batch, [2,1,3,4]);
        if size(batch,3) == 3
            batch = batch(:,:,[3,2,1],:);
        end        
        label = reshape(label, [1,1,1,length(label)]);
        batch = single(batch) / 255.0 - 0.5;
        label = single(label);
        net_input = {batch, label};        
        caffe_net_reshape_as_input(solver.net, net_input);
        caffe_net_set_input_data(solver.net, net_input);
        solver.step(1);
        
        if opt.display.progress
            progressbar((epoch-1+b/num_batches)/max_epoches,b/num_batches+0.001);
        end
    end
    
    acc = -1.0;
    if opt.do_val
        acc = do_validate(solver.test_nets, valid_dataset, opt);
    end
    if opt.display.visualize
        opt.output.acc_valid = [opt.output.acc_valid, acc];
        plot_acc_curve(opt.output.acc_valid);
    end
    fprintf('epoch: % 3d, acc: %3.4f\n', epoch, acc);
end

end
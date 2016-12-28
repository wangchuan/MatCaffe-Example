function acc = do_validate(net, dataset, opt)
batch_size = opt.batch_size;
num_samples = length(dataset.labels);
num_batches = ceil(num_samples / batch_size);

acc = 0.0;
for b = 1:num_batches
    s = (b - 1) * batch_size;
    batch = dataset.data(:,:,:,s+1:min(end,s+batch_size));
    label = dataset.labels(s+1:min(end,s+batch_size));
    batch = permute(batch, [2,1,3,4]);
    if size(batch,3) == 3
        batch = batch(:,:,[3,2,1],:);
    end
    label = reshape(label, [1,1,1,length(label)]);
    batch = single(batch) / 255.0 - 0.5;
    label = single(label);
    net_input = {batch, label};
    caffe_net_reshape_as_input(net, net_input);
    net.forward(net_input);
    acc = acc + net.blobs('accuracy').get_data() * length(label);
end
acc = acc / num_samples;

end
function [net] = caffe_net_set_input_data(net, input_data)
CHECK(iscell(input_data), 'input_data must be a cell array');
CHECK(length(input_data) == length(net.inputs), ...
    'input data cell length must match input blob number');
% copy data to input blobs
for n = 1:length(net.inputs)
    net.blobs(net.inputs{n}).set_data(input_data{n});
end
end
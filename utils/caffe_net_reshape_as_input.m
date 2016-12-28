function [net] = caffe_net_reshape_as_input(net, input_data)
CHECK(iscell(input_data), 'input_data must be a cell array');
CHECK(length(input_data) == length(net.inputs), ...
    'input data cell length must match input blob number');
% reshape input blobs
for n = 1:length(net.inputs)
    if isempty(input_data{n})
        continue;
    end
    input_data_size = size(input_data{n});
    input_data_size_extended = [input_data_size, ones(1, 4 - length(input_data_size))];
    net.blobs(net.inputs{n}).reshape(input_data_size_extended);
end
net.reshape();
end


function [] = convert_imgs_to_mat(fdname, out_filename)
tic;
%%
fid = fopen(fullfile(fdname, 'labels.txt'), 'r');
rst = textscan(fid, '%s%d');
filelist = rst{1};
labels = rst{2};
num_files = length(labels);
filename = fullfile(fdname, filelist{1});
im = imread(filename);
data = zeros([size(im,1), size(im,2), size(im,3), num_files], 'uint8');
if num_files <= 10000
    data = serial_convert(data, num_files, fdname, filelist); 
else
    data = parallel_convert(data, num_files, fdname, filelist); 
end
save(out_filename, 'data', 'labels');
toc;
end

function data = serial_convert(data, num_files, fdname, filelist)
for i = 1:num_files
    filename = fullfile(fdname, filelist{i});
    im = imread(filename);
    data(:,:,:,i) = im;
end
end

function data = parallel_convert(data, num_files, fdname, filelist)
parfor i = 1:num_files
    filename = fullfile(fdname, filelist{i});
    im = imread(filename);
    data(:,:,:,i) = im;
end
end

import lmdb
import numpy as np
import caffe
import os
import cv2
import pdb

def main():
	print('wh')

def convert_to_jpgs(indir, outdir):
	if not os.path.exists(outdir):
		os.makedirs(outdir)
	datum = caffe.proto.caffe_pb2.Datum()
	print('converting...')
	f = open(os.path.join(outdir, 'labels.txt'), 'w')
	with lmdb.open(indir, readonly=True).begin().cursor() as cursor:
		for key, raw_datum in cursor:
			datum.ParseFromString(raw_datum)
			im = np.fromstring(datum.data, dtype=np.uint8)
			im = im.reshape(datum.channels, datum.height, datum.width)
			im = np.transpose(im, (1,2,0))
			if datum.channels == 3:
				im = im[:,:,(2,1,0)]
			label = datum.label			
			im_filename = key + '.jpg'
			cv2.imwrite(os.path.join(outdir, im_filename), im)
			f.write(im_filename + ' ' + str(label) + '\n')
	f.close()
	print('done')

if __name__ == '__main__':
	lmdb_dir = '/home/cwang/caffe/examples/cifar10/cifar10_train_lmdb'
	outdir = './cifar10/train'
	convert_to_jpgs(lmdb_dir, outdir)

	lmdb_dir = '/home/cwang/caffe/examples/cifar10/cifar10_test_lmdb'
	outdir = './cifar10/test'
	convert_to_jpgs(lmdb_dir, outdir)

	

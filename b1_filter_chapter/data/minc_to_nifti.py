"""Convert minc to nifti format."""

import os
import numpy as np
from nibabel import load, save, Nifti1Image

minc = load("/Users/mathieuboudreau/neuropoly/blogs/mtr-mtsat/t1_notebooks/b1_filter_chapter/data/b1_whole_brain/stikov_nikola_20131017_113942_21d2_mri.mnc")
basename = minc.get_filename().split(os.extsep, 1)[0]

affine = np.array([[0, 0, 1, 0],
                   [0, 1, 0, 0],
                   [1, 0, 0, 0],
                   [0, 0, 0, 1]])

out = Nifti1Image(np.asanyarray(minc.dataobj), affine=affine)
save(out, basename + '.nii.gz')

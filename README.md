# DFN_reconstruction 
## Description
This repository provides the MATLAB implementation of a framework for reconstructing three-dimensional discrete fracture networks (DFN) constrained by borehole logging data.

The method integrates stochastic DFN generation with a simulated annealing (SA) optimization algorithm to iteratively adjust fracture parameters so that simulated borehole intersections reproduce the statistical characteristics observed in logging measurements..
## Requirements
- PyTorch>=2.5.0
- OpenCV-Python>=4.6.0
- Cuda>=12.5.51
- Matplotlib>=3.5.1
- Numpy>=1.24.4
- Tifffile>=2023.7.0
## Usage
### Preparing
In order to run the code correctly, you first need to prepare an image and change it to a grayscale image (0-255). Then copy the image to the Raw Image folder (./Raw image). In run_stliceganrfb.py, there are three functions, including training the model, generating digital core images, and generating image from different checkpoints.
### Train a model
`python run_sliceganrfb 1`
### Generate a digital core
`python run_sliceganrfb 2`\
<img width="1301" height="1764" alt="图片1" src="https://github.com/user-attachments/assets/aa7a7831-fde7-430a-9f0e-d77f40f13c3c" />
### Creat a digital core from checkpoint ***n***
In this program, n indicates the value of the checkpoint, usually 5, 10, 15, 20, etc.  
`python run_sliceganrfb n`
### Hyperparameters
For detailed hyperparameters, please refer to the article (Feng et al., 2026) "Three dimensional digital core reconstruction from 2D SEM images of heterogeneous shale samples". A reasonable set of input parameters are as follows:
```python  
Epoch = 100 # The number of Epoch  
Batch = 8    # The number of images in every batch  
D batch size = 8 # The number of images in every batch for discriminator  
Critic iters = 10 # critic update steps
Img size = 64 # The size of generated image  
Img channels = 6 (in my study) # it depends on the channels number of your image
```


## Attention
The 3D digital core generated using SliceganRFB requires a series of image processing (dissolution, dilation, segmentation, etc.) to obtain an image that is close to CT images. Given the size of the digital core image (64 * 64 * 64), we recommend a GPU memory of 24GB (RTX 4090), but since we have not tested it on an AMD GPU, we cannot determine if it will work. If you have larger GPU memory, we recommend generating larger sized digital core images because larger images represent more information and higher resolution.

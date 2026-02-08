# Lab7: Bicubic Interpolation for 2D Image Enlargement

## Homework

- **2D Image Scaling using Bicubic Interpolation**:
  - Extends Lab6 to two-dimensional bicubic interpolation for high-quality image enlargement
  - Processes 128×128 RGB images with row-major memory mapping
  - RGB to grayscale conversion using weighted formula with banker's rounding
  - Two-stage interpolation: horizontal then vertical using 16 surrounding points
  - Replication padding for boundary handling
  - Generates enlarged grayscale output images

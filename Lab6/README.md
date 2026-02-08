# Lab6: Cubic Interpolation for Image Enlargement

## Homework

- **1D Image Scaling using Cubic Interpolation**:
  - Implements cubic polynomial interpolation (p(x) = ax³ + bx² + cx + d) for smooth image enlargement
  - Uses 4-point neighborhood (P(-1), P(0), P(1), P(2)) to calculate interpolated values
  - Solves system of equations for polynomial coefficients based on pixel values and slopes
  - Enlarges 29×30 image to 61×30 with hidden message extraction
  - Row-major memory mapping for input/output with boundary handling

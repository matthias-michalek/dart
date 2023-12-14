# Parameters of dartboard.

const nsections = 20

const radii = [6.35, 16.0, 99.0, 107.0, 162.0, 170.0]
const φs = LinRange(0, 2π * (1 - 1 / nsections), nsections)

# points
const bullseye = [50, 25]
# Order of sections from x-axis in polar angle
const points = [6, 13, 4, 18, 1, 20, 5, 12, 9, 14, 11, 8, 16, 7, 19, 3, 17, 2, 15, 10]

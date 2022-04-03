[Mesh]
 type = GeneratedMesh #to generate simple mesh (lines, rectangles etc.)
 dim = 2 # Dimension of the mesh is 2D
 nx = 100 # number of elements in x direction 
 ny = 10 # number of elements in y direction 
 xmax = 0.304 # length of  test volume in x directoin
 ymax = 0.0257 # length of test volume in y direction 
 []
 
 
[Problem] # transform 2D geometry to 3D rotational axisymmetric
 type = FEProblem # "normal" type of finite element problem in MOOSE
 coord_type=RZ # define axis of symmetry (around Z)
 rz_coord_axis=X #define Z axis as the X axis of the geometry defines in bloc kMEsh
 []
 

[Variables]
 [pressure]
  #adds a linera Lagrange by default
  []
 []

  
[Kernels]
 [diffusion]
   type = DarcyPressure # laplacian operator
   variable = pressure #to which variable to apply the opreator 
  []
 []


[BCs]
 [inlet]
  type =ADDirichletBC # aimple u=value BC
  variable = pressure # to which variable the BC applies 
  boundary = left # where is the BC
  value = 4000 # value of the BC
 []
 [outlet]
  type = ADDirichletBC
  variable = pressure
  boundary = right
  value = 0
 []
[]


[Executioner] # solver (time dependent etc.)
 type = Steady
 solve_type = NEWTON
 petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below # set PETSc parameters to optimize solution
 petsc_options_value = ' hypre    boomeramg'
 []


[Outputs]
 exodus = true # output exodus format  
 []

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 



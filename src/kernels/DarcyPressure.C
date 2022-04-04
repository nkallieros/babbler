#include "DarcyPressure.h"

registerMooseObject("BabblerApp", DarcyPressure);

InputParameters
DarcyPressure::validParams()
{
  InputParameters params = ADKernelGrad::validParams();
  params.addClassDescription("Compute the diffusion term for Darcy pressure ($p$) equation: "
                             "$-\\nabla \\cdot \\frac{\\mathbf{K}}{\\mu} \\nabla p = 0$");
                             
  // add a required parameter. if this is not provided in the input file MOOSE will error
  params.addRequiredParam<Real>("permeability","the isotropic permeability ($k$) of the medium");
  
  // add an optional parameterand set its default value 
  params.addParam<Real>(
     "viscosity",
     7.98e-04,
     "the dynamic viscosity ($\\mu$) of the fluid, the default value is that of water at 30"
     "degrees celcius (7.98e-04 Pa-s).");
     

  return params;
}

DarcyPressure::DarcyPressure(const InputParameters & parameters)
  : ADKernelGrad(parameters),

    // get the parameters from the input file 
    _permeability(getParam<Real>("permeability")),
    _viscosity(getParam<Real>("viscosity"))
{
}

ADRealVectorValue
DarcyPressure::precomputeQpResidual()
{
  return (_permeability / _viscosity) * _grad_u[_qp];
}

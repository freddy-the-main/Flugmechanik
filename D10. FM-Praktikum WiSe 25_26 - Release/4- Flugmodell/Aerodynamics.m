function Aerodynamics(block)

 % Level-2 MATLAB file S-Function for times two demo.
 %   Copyright 1990-2009 The MathWorks, Inc.
 %   $Revision: 1.1.6.2 $ 
 
 setup(block);
 
 %endfunction

function setup(block)

 %% Specify the number of parmeters
 block.NumDialogPrms = 0;                                % <<< Edit: enter the number of block parameters
 
 %% Register number of input and output ports
 block.NumInputPorts  = 1;                               % <<< Edit: enter the number of input ports
  
 block.NumOutputPorts = 2;                               % <<< Edit: enter the number of output ports
 block.OutputPort(1).SamplingMode = 'Sample';  
 block.OutputPort(2).SamplingMode = 'Sample';
 
 %% Setup functional port properties to dynamically
 %% inherited.
 block.SetPreCompInpPortInfoToDynamic;
 block.SetPreCompOutPortInfoToDynamic;
  
 block.InputPort(1).Dimensions        = 13;               % <<< Edit: enter the dimension of the intput ports
 block.InputPort(1).DirectFeedthrough = true;
   
 block.OutputPort(1).Dimensions       = 3;               % <<< Edit: enter the dimension of the output ports
 block.OutputPort(2).Dimensions       = 3;               % <<< Edit: enter the dimension of the output ports
 
 %% Set block sample time to inherited
 block.SampleTimes = [-1 0];
 
 block.RegBlockMethod('SetInputPortSamplingMode', @SetInpPortFrameData);
   
 %% Set the block simStateCompliance to default (i.e., same as a built-in block)
 block.SimStateCompliance = 'DefaultSimState';
 
 %% Run accelerator on TLC
 block.SetAccelRunOnTLC(true);
   
 %% Register methods
 block.RegBlockMethod('Outputs', @Output);  
   
 %endfunction

function SetInpPortFrameData(block, idx, fd) % <<< Edit: enter the sampling mode for inpiuts and outputs
  
  block.InputPort(idx).SamplingMode = fd;
  block.OutputPort(1).SamplingMode  = fd;
  block.OutputPort(2).SamplingMode  = fd;

function Output(block)
 
 % Input definition
 ail    	= block.InputPort(1).Data(1);   	% aileron deflection [rad]
 elev   	= block.InputPort(1).Data(2);   	% elevator deflection [rad]
 rud    	= block.InputPort(1).Data(3);   	% rudder deflection [rad]
 tas    	= block.InputPort(1).Data(4);   	% true airspeed [m/s]
 beta   	= block.InputPort(1).Data(5);   	% side slip angle [rad]
 alpha  	= block.InputPort(1).Data(6);   	% angle of attack [rad]
 tas_dot  	= block.InputPort(1).Data(7);   	% true airspeed [m/s]
 beta_dot	= block.InputPort(1).Data(8);   	% side slip angle [rad]
 alpha_dot	= block.InputPort(1).Data(9);   	% angle of attack [rad]
 p      	= block.InputPort(1).Data(10);   	% roll rate [rad/s]
 q      	= block.InputPort(1).Data(11);   	% pitch rate [rad/s]
 r      	= block.InputPort(1).Data(12);   	% yaw rate [rad/s]
 Pdyn   	= block.InputPort(1).Data(13);   	% dynamic pressure [Pa]
 
 %% Conversation factors
cLBS2KG         = 0.453592;                 % conversion factor lbs to kg
cFT2M           = 0.3048;
cFTsq2Msq       = 0.3048 * 0.3048;
cSLUGFTsg2KGMsq = 1.3558179619;             % conversion slug ft² to kg m²
cFTpS2MpS       = 0.3048;                   % conversion ft/s to m/s


 % Function Parameters
 S 			= 280 * cFTsq2Msq;			% wing reference area [m2]
 c			= 6.5 * cFT2M;				% MAC [m]
 b 			= 46 * cFT2M;			    % wing span [m]
 
 %% ----- Derivatives -----	
 % Longitudinal	
 CW0 			= 0.0969;
 CWalpha 		= 0.933;		
 
 CA0			= 0.76;	
 CAalpha 		= 6.24;
 CAq 			= 8.1;	
 CAeta			= 0.58;
 CAalphadot		= 2.7;
 CAtas          = 0.027;
			
 Cm0			=  0.1; 	      
 Cmalpha		= -2.08;
 Cmalphadot		= -9.1;
 Cmq			= -34.0; 	   
 Cmeta 			= -1.9; 	   

 % Lateral	
 CQ0			=  0.00;		
 CQbeta			= -0.59;				
 CQp			= -0.21;	
 CQr			=  0.39;			
 CQrud			=  0.144;	
 
 Cl0			=  0.0;
 Clbeta			= -0.13;	
 Clp			= -0.5;
 Clr			=  0.06;
 Clail			= -0.156;
 Clrud  		=  0.0087;
 
 Cn0			=  0.00;	
 Cnbeta			=  0.12;	
 Cnp 			= -0.005;	
 Cnr 			= -0.204;
 Cnail			= -0.0012;
 Cnrud  		= -0.0763;		
 		
 % Code. DO NOT EDIT !!!
 % rate star
 p_star         = (p * b) / (2 * tas);
 q_star         = (q * c) / (2 * tas);
 r_star         = (r * b) / (2 * tas); 
 alphadot_star  = (alpha_dot * c) / (2 * tas);
 betadot_star   = (beta_dot * b) / (2 * tas);
 
 % drag coefficient
 CW = CW0 + CWalpha * abs(alpha);
 % lift coefficient
 CA = CA0 + CAalpha * alpha + CAq * q_star + CAeta * elev + CAalphadot * alphadot_star;
 % pitch moment coefficient
 Cm = Cm0 + Cmalpha * alpha + Cmq * q_star + Cmeta * elev + Cmalphadot * alphadot_star;
 % side force coefficient
 CQ = CQ0 + CQbeta * beta + CQp	* p_star + CQr * r_star + CQrud * rud;
 % roll moment coefficient
 Cl = Cl0 + Clbeta * beta + Clp * p_star + Clr * r_star + Clail * ail + Clrud * rud; 
 % yaw moment coefficient
 Cn = Cn0 + Cnbeta * beta + Cnp * p_star + Cnr * r_star + Cnrud * rud + Cnail * ail;      		
      		
 % Transformation of the coef. into the body frames
 CX_B   	=  CA*sin(alpha) - CW*cos(alpha);
 CY_B   	=  CQ;
 CZ_B   	= -CA*cos(alpha) - CW*sin(alpha); 
 
 CL_B      	=  Cl*cos(alpha) - Cn*sin(alpha);   % rel. to the CG
 CM_B      	=  Cm;                              % rel. to the CG
 CN_B      	=  Cl*sin(alpha) + Cn*cos(alpha);   % rel. to the CG    
 
 % Calculation of the aero. body forces and moments
 F_body(1) 	= CX_B * Pdyn * S;
 F_body(2) 	= CY_B * Pdyn * S;
 F_body(3) 	= CZ_B * Pdyn * S;
    
 M_body(1)  = CL_B * Pdyn * S * (b / 1.0);
 M_body(2) 	= CM_B * Pdyn * S * c;
 M_body(3) 	= CN_B * Pdyn * S * (b / 1.0);  
 
 % Output definition
 % 3D thrust
 block.OutputPort(1).Data(1) = F_body(1);
 block.OutputPort(1).Data(2) = F_body(2);
 block.OutputPort(1).Data(3) = F_body(3);
 % 3D moment
 block.OutputPort(2).Data(1) = M_body(1);
 block.OutputPort(2).Data(2) = M_body(2);
 block.OutputPort(2).Data(3) = M_body(3);
 
 %endfunction

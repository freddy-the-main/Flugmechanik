function FMS(block)

 % Level-2 MATLAB file S-Function for times two demo.
 %   Copyright 1990-2009 The MathWorks, Inc.
 %   $Revision: 1.1.6.2 $ 
 
 setup(block);
 
 %endfunction

function setup(block)

 %% Specify the number of parmeters
 block.NumDialogPrms = 0;                                % <<< Edit: enter the number of block parameters
 
 %% Register number of input and output ports
 block.NumInputPorts  = 2;                               % <<< Edit: enter the number of input ports
  
 block.NumOutputPorts = 2;                               % <<< Edit: enter the number of output ports
 block.OutputPort(1).SamplingMode = 'Sample';  
 block.OutputPort(2).SamplingMode = 'Sample';
 
 %% Setup functional port properties to dynamically
 %% inherited.
 block.SetPreCompInpPortInfoToDynamic;
 block.SetPreCompOutPortInfoToDynamic;
  
 block.InputPort(1).Dimensions        = 2;               % <<< Edit: enter the dimension of the intput ports
 block.InputPort(1).DirectFeedthrough = true;
   
 block.InputPort(2).Dimensions        = 1;               % <<< Edit: enter the dimension of the intput ports
 block.InputPort(2).DirectFeedthrough = true;
   
 block.OutputPort(1).Dimensions       = 4;               % <<< Edit: enter the dimension of the output ports
 block.OutputPort(2).Dimensions       = 4;               % <<< Edit: enter the dimension of the output ports
 
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
 Simutime   = block.InputPort(1).Data(1);   	% 
 FMS_ON     = block.InputPort(1).Data(2);   	% 
 ALT        = block.InputPort(2).Data(1);

persistent StartTime OLD_FMS_ON Last_ALT
        
if isempty(StartTime)
    StartTime   = Simutime;
    OLD_FMS_ON  = 0;
    return
end
    
if(FMS_ON > OLD_FMS_ON)
    StartTime   = Simutime;
    OLD_FMS_ON = FMS_ON;
end

if(FMS_ON == 0)
    OLD_FMS_ON = FMS_ON;
end

FMS_Time = Simutime - StartTime;

if(FMS_Time > 200)
    StartTime   = Simutime;
    OLD_FMS_ON = FMS_ON;
end

if(FMS_Time < 45) % steady horizontal flight
    CMD_BANK    = 0;
    CMD_IAS     = 130; % Beechcraft 99
    CMD_ROC     = 0;
    CMD_ALT     = ALT;
    % -----
    Set_BANK    = 1;
    Set_IAS     = 1;
    Set_ROC     = 1;
    Set_ALT     = 0;
elseif(FMS_Time < 105) % climb with right curve
    CMD_BANK    = 30;
    CMD_IAS     = 115; %  
    CMD_ROC     = 300;
    CMD_ALT     = ALT;
    % -----
    Set_BANK    = 1;
    Set_IAS     = 1;
    Set_ROC     = 1;
    Set_ALT     = 0;
elseif(FMS_Time < 155) % climb with left curve
    CMD_BANK    = -30;
    CMD_IAS     = 110; % Boeing 747: 270
    CMD_ROC     = 200;
    CMD_ALT     = ALT;
    % -----
    Set_BANK    = 1;
    Set_IAS     = 1;
    Set_ROC     = 1;
    Set_ALT     = 0;
    % -----
    Last_ALT = ALT;
elseif(FMS_Time < 200) % descend with wing level
    CMD_BANK    = 0;
    CMD_IAS     = 120; % Boeing 747: 230
    CMD_ROC     = 0;
    CMD_ALT     = Last_ALT - 1200;
    % -----
    Set_BANK    = 1;
    Set_IAS     = 1;
    Set_ROC     = 0;
    Set_ALT     = 1;
else
    CMD_BANK    = 35;
    CMD_IAS     = 220; % Boeing 747: 230
    CMD_ROC     = 1600;
    CMD_ALT     = Last_ALT - 3000;
    % -----
    Set_BANK    = 1;
    Set_IAS     = 1;
    Set_ROC     = 1;
    Set_ALT     = 0;
end

if(CMD_ALT < 2000)
    CMD_ALT = 2000;
end

if(CMD_ALT > 30000)
    CMD_ALT = 30000;
    if(CMD_ROC > 0)
        CMD_ROC = 0;
    end
end
    		
 % Output definition
 % 3D thrust
 block.OutputPort(1).Data(1) = CMD_BANK;
 block.OutputPort(1).Data(2) = CMD_IAS;
 block.OutputPort(1).Data(3) = CMD_ROC;
 block.OutputPort(1).Data(4) = CMD_ALT;
 % 3D moment
 block.OutputPort(2).Data(1) = Set_BANK;
 block.OutputPort(2).Data(2) = Set_IAS;
 block.OutputPort(2).Data(3) = Set_ROC;
 block.OutputPort(2).Data(4) = Set_ALT;
 
 %endfunction

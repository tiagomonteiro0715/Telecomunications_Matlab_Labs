function [ret,x0,str,ts,xts]=soma_sen(t,x,u,flag);
%SOMA_SEN	is the M-file description of the SIMULINK system named SOMA_SEN.
%	The block-diagram can be displayed by typing: SOMA_SEN.
%
%	SYS=SOMA_SEN(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes SOMA_SEN to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling SOMA_SEN with a FLAG of zero:
%	[SIZES]=SOMA_SEN([],[],[],0),  returns a vector, SIZES, which
%	contains the sizes of the state vector and other parameters.
%		SIZES(1) number of states
%		SIZES(2) number of discrete states
%		SIZES(3) number of outputs
%		SIZES(4) number of inputs
%		SIZES(5) number of roots (currently unsupported)
%		SIZES(6) direct feedthrough flag
%		SIZES(7) number of sample times
%
%	For the definition of other parameters in SIZES, see SFUNC.
%	See also, TRIM, LINMOD, LINSIM, EULER, RK23, RK45, ADAMS, GEAR.

% Note: This M-file is only used for saving graphical information;
%       after the model is loaded into memory an internal model
%       representation is used.

% the system will take on the name of this mfile:
sys = mfilename;
new_system(sys)
simver(1.3)
if (0 == (nargin + nargout))
     set_param(sys,'Location',[4,50,1263,849])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '999999')
set_param(sys,'Min step size', '0.00005')
set_param(sys,'Max step size', '0.001')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
		'inputs','+++',...
		'position',[650,187,660,223])

add_block('built-in/Signal Generator',[sys,'/',['Signal',13,'Generator3']])
set_param([sys,'/',['Signal',13,'Generator3']],...
		'Peak','1.000000',...
		'Peak Range','5.000000',...
		'Freq','636.620000',...
		'Freq Range','5625.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[495,78,540,112])

add_block('built-in/Signal Generator',[sys,'/',['Signal',13,'Generator1']])
set_param([sys,'/',['Signal',13,'Generator1']],...
		'Peak','1.000000',...
		'Peak Range','5.000000',...
		'Freq','159.154000',...
		'Freq Range','5625.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[490,258,535,292])

add_block('built-in/Signal Generator',[sys,'/',['Signal',13,'Generator2']])
set_param([sys,'/',['Signal',13,'Generator2']],...
		'Peak','1.000000',...
		'Peak Range','5.000000',...
		'Freq','318.310000',...
		'Freq Range','5625.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[475,178,520,212])


%     Subsystem  'Graph'.

new_system([sys,'/','Graph'])
set_param([sys,'/','Graph'],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/','Graph/x'])
set_param([sys,'/','Graph/x'],...
		'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Graph/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Graph/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfuny',...
		'parameters','ax, color,dt',...
		'position',[130,55,180,75])
add_line([sys,'/','Graph'],[90,65;125,65])
set_param([sys,'/','Graph'],...
		'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
		'Mask Type','Graph scope.')
set_param([sys,'/','Graph'],...
		'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','Graph'],...
		'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','Graph'],...
		'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','Graph'],...
		'Mask Entries','0.1\/-4\/4\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
		'position',[1005,201,1035,239])

add_block('built-in/State-Space',[sys,'/',['Analog Butterworth',13,'BP Filter ']])
set_param([sys,'/',['Analog Butterworth',13,'BP Filter ']],...
		'A','at',...
		'B','bt',...
		'C','ct',...
		'D','dt',...
		'Mask Display','plot(w,mag)',...
		'Mask Type','buttap,lp2bp')
set_param([sys,'/',['Analog Butterworth',13,'BP Filter ']],...
		'Mask Dialogue','Analog Butterworth band pass filter.\n\n(Requires Signal Processing Toolbox)|Center frequency (rad/sec)|Bandwidth (rad/sec):|Order')
set_param([sys,'/',['Analog Butterworth',13,'BP Filter ']],...
		'Mask Translate','[at,bt,ct,dt,w,mag]=filtm(''buttap'',''lp2bp'',@1,@2,50,@3);',...
		'Mask Help','Butterworth band pass filter using MATLAB''s butter and lp2bp command.')
set_param([sys,'/',['Analog Butterworth',13,'BP Filter ']],...
		'Mask Entries','318.31\/1.5915\/2\/',...
		'position',[790,199,850,241])
add_line(sys,[545,95;590,95;590,195;645,195])
add_line(sys,[525,195;580,195;580,205;645,205])
add_line(sys,[540,275;585,275;585,215;645,215])
add_line(sys,[665,205;715,205;715,220;785,220])
add_line(sys,[855,220;1000,220])

drawnow

% Return any arguments.
if (nargin | nargout)
	% Must use feval here to access system in memory
	if (nargin > 3)
		if (flag == 0)
			eval(['[ret,x0,str,ts,xts]=',sys,'(t,x,u,flag);'])
		else
			eval(['ret =', sys,'(t,x,u,flag);'])
		end
	else
		[ret,x0,str,ts,xts] = feval(sys);
	end
else
	drawnow % Flash up the model and execute load callback
end

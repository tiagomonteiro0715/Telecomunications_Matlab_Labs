function [ret,x0,str,ts,xts]=deriv(t,x,u,flag);
%DERIV	is the M-file description of the SIMULINK system named DERIV.
%	DERIV has a the following characteristics:
%		1 continuous states
%		9 discrete states
%		0 outputs
%		0 inputs
%		does not have direct feedthrough
%		1 sample times
%
%	The block-diagram can be displayed by typing: DERIV.
%
%	SYS=DERIV(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes DERIV to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling DERIV with a FLAG of zero:
%	[SIZES]=DERIV([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[0,46,1259,845])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '999999')
set_param(sys,'Min step size', '0.00001')
set_param(sys,'Max step size', '0.0001')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')


%     Subsystem  ['Repeating',13,'Sequence'].

new_system([sys,'/',['Repeating',13,'Sequence']])
set_param([sys,'/',['Repeating',13,'Sequence']],'Location',[5,40,315,196])

add_block('built-in/Outport',[sys,'/',['Repeating',13,'Sequence/out_1']])
set_param([sys,'/',['Repeating',13,'Sequence/out_1']],...
		'position',[285,60,305,80])

add_block('built-in/Look Up Table',[sys,'/',['Repeating',13,'Sequence/Look-Up Table']])
set_param([sys,'/',['Repeating',13,'Sequence/Look-Up Table']],...
		'Input_Values','t',...
		'Output_Values','y',...
		'position',[210,58,250,82])

add_block('built-in/Fcn',[sys,'/',['Repeating',13,'Sequence/Fcn1']])
set_param([sys,'/',['Repeating',13,'Sequence/Fcn1']],...
		'Expr','rem(u[1],period)',...
		'position',[110,60,150,80])

add_block('built-in/Clock',[sys,'/',['Repeating',13,'Sequence/Clock']])
set_param([sys,'/',['Repeating',13,'Sequence/Clock']],...
		'position',[45,60,65,80])
add_line([sys,'/',['Repeating',13,'Sequence']],[255,70;280,70])
add_line([sys,'/',['Repeating',13,'Sequence']],[70,70;105,70])
add_line([sys,'/',['Repeating',13,'Sequence']],[155,70;205,70])
set_param([sys,'/',['Repeating',13,'Sequence']],...
		'Mask Display','plot([t,t+period,t+2*period],[y,y,y])',...
		'Mask Type','Repeating table')
set_param([sys,'/',['Repeating',13,'Sequence']],...
		'Mask Dialogue','Repeating table.\nEnter values of time and output for first cycle.|Time values:|Output values:',...
		'Mask Translate','period = max(@1); t = @1; y = @2;')
set_param([sys,'/',['Repeating',13,'Sequence']],...
		'Mask Help','Repeats cycle given in table. Time values should be monotonically increasing.',...
		'Mask Entries','[0 0.1 0.1 0.2 0.2 0.5 0.5 0.6 0.6]\/[ 0 0 5 5 0 0 5 5 0]\/')


%     Finished composite block ['Repeating',13,'Sequence'].

set_param([sys,'/',['Repeating',13,'Sequence']],...
		'position',[155,457,190,493])

add_block('built-in/Scope',[sys,'/','Scope'])
set_param([sys,'/','Scope'],...
		'Vgain','7.000000',...
		'Hgain','7.000000',...
		'Vmax','14.000000',...
		'Hmax','14.000000',...
		'Window',[59,11,960,805],...
		'position',[285,460,315,490])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
		'position',[290,530,310,550])

add_block('built-in/Gain',[sys,'/','Gain'])
set_param([sys,'/','Gain'],...
		'Gain','5',...
		'position',[350,532,375,558])

add_block('built-in/Derivative',[sys,'/','Derivative'])
set_param([sys,'/','Derivative'],...
		'position',[365,615,395,635])


%     Subsystem  ['Auto-Scale',13,'Graph'].

new_system([sys,'/',['Auto-Scale',13,'Graph']])
set_param([sys,'/',['Auto-Scale',13,'Graph']],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/',['Auto-Scale',13,'Graph/x']])
set_param([sys,'/',['Auto-Scale',13,'Graph/x']],...
		'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Auto-Scale',13,'Graph/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Auto-Scale',13,'Graph/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfunyst',...
		'parameters','ax, color, npts, dt',...
		'position',[130,55,180,75])
add_line([sys,'/',['Auto-Scale',13,'Graph']],[90,65;125,65])
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
		'Mask Display','plot(0,0,100,100,[83,76,63,52,42,38,28,16,11,84,11,11,11,90,90,11],[75,58,47,54,72,80,84,74,65,65,65,90,40,40,90,90])',...
		'Mask Type','Storage scope.')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
		'Mask Dialogue','Storage scope using MATLAB graph window.\nEnter plotting ranges and line type.|Initial Time Range:|Initial y-min:|Initial y-max:|Storage pts.:|Line type (rgbw-.:xo):')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
		'Mask Translate','npts = @4; color = @5; ax = [0, @1, @2, @3]; dt=-1;')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
		'Mask Help','This block uses a MATLAB figure window to plot the input signal.  The graph limits are automatically scaled to the min and max values of the signal stored in the scope''s signal buffer.  Line type must be in quotes.  See the M-file sfunyst.m.')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
		'Mask Entries','5\/-10\/10\/200\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Auto-Scale',13,'Graph'].

set_param([sys,'/',['Auto-Scale',13,'Graph']],...
		'position',[1140,490,1170,530])

add_block('built-in/Abs',[sys,'/','Abs'])
set_param([sys,'/','Abs'],...
		'position',[480,613,510,637])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
		'inputs','3',...
		'position',[880,493,910,527])

add_block('built-in/Saturation',[sys,'/','Saturation'])
set_param([sys,'/','Saturation'],...
		'Lower Limit','0',...
		'Upper Limit','5',...
		'position',[605,613,635,637])

add_block('built-in/Transport Delay',[sys,'/',['Transport',13,'Delay']])
set_param([sys,'/',['Transport',13,'Delay']],...
		'position',[695,610,735,640])
add_line(sys,[195,475;280,475])
add_line(sys,[230,475;225,540;285,540])
add_line(sys,[250,475;250,500;875,500])
add_line(sys,[915,510;1135,510])
add_line(sys,[315,540;325,540;325,545;345,545])
add_line(sys,[380,545;395,545;525,510;875,510])
add_line(sys,[240,540;240,625;360,625])
add_line(sys,[400,625;395,620])
add_line(sys,[400,625;475,625])
add_line(sys,[515,625;600,625])
add_line(sys,[640,625;690,625])
add_line(sys,[740,625;800,625;800,520;875,520])

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

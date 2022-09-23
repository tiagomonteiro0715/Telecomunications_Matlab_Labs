function [ret,x0,str,ts,xts]=seque2(t,x,u,flag);
%SEQUE2	is the M-file description of the SIMULINK system named SEQUE2.
%	SEQUE2 has a the following characteristics:
%		0 continuous states
%		0 discrete states
%		0 outputs
%		0 inputs
%		does not have direct feedthrough
%		1 sample times
%
%	The block-diagram can be displayed by typing: SEQUE2.
%
%	SYS=SEQUE2(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes SEQUE2 to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling SEQUE2 with a FLAG of zero:
%	[SIZES]=SEQUE2([],[],[],0),  returns a vector, SIZES, which
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
		'Mask Help','Repeats cycle given in table. Time values should be monotonically increasing.')
set_param([sys,'/',['Repeating',13,'Sequence']],...
		'Mask Entries','[0 0.1 0.1 0.2 0.2 0.5 0.5 0.6 0.6 0.7 0.7 1 1]\/[0 0 5 5 0 0 5 0 0 5 5 0 0 5]\/')


%     Finished composite block ['Repeating',13,'Sequence'].

set_param([sys,'/',['Repeating',13,'Sequence']],...
		'position',[155,457,190,493])

add_block('built-in/Scope',[sys,'/','Scope'])
set_param([sys,'/','Scope'],...
		'Vgain','11.000000',...
		'Hgain','11.000000',...
		'Vmax','22.000000',...
		'Hmax','22.000000',...
		'Window',[50,10,951,804],...
		'position',[285,460,315,490])
add_line(sys,[195,475;280,475])

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

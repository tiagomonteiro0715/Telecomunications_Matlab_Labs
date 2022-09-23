function [ret,x0,str,ts,xts]=sinal(t,x,u,flag);
%SINAL	is the M-file description of the SIMULINK system named SINAL.
%	The block-diagram can be displayed by typing: SINAL.
%
%	SYS=SINAL(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes SINAL to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling SINAL with a FLAG of zero:
%	[SIZES]=SINAL([],[],[],0),  returns a vector, SIZES, which
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

add_block('built-in/Scope',[sys,'/',['vis 1',13,'']])
set_param([sys,'/',['vis 1',13,'']],...
		'Vgain','10.000000',...
		'Hgain','0.100000',...
		'Vmax','20.000000',...
		'Hmax','0.200000',...
		'Window',[538,113,916,470],...
		'position',[320,205,350,235])


%     Subsystem  'Sinal T'.

new_system([sys,'/','Sinal T'])
set_param([sys,'/','Sinal T'],'Location',[75,69,301,248])

add_block('built-in/Sum',[sys,'/','Sinal T/Sum1'])
set_param([sys,'/','Sinal T/Sum1'],...
		'position',[150,85,170,105])

add_block('built-in/Signal Generator',[sys,'/',['Sinal T/sinal',13,'1']])
set_param([sys,'/',['Sinal T/sinal',13,'1']],...
		'Peak','4.000000',...
		'Peak Range','0.000000',...
		'Freq','500.000000',...
		'Freq Range','5000.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[30,103,75,137])

add_block('built-in/Signal Generator',[sys,'/',['Sinal T/sinal',13,'']])
set_param([sys,'/',['Sinal T/sinal',13,'']],...
		'Peak','4.000000',...
		'Peak Range','0.000000',...
		'Freq','1000.000000',...
		'Freq Range','5000.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[30,33,75,67])

add_block('built-in/Outport',[sys,'/','Sinal T/out_1'])
set_param([sys,'/','Sinal T/out_1'],...
		'position',[200,85,220,105])
add_line([sys,'/','Sinal T'],[80,120;105,120;105,100;145,100])
add_line([sys,'/','Sinal T'],[80,50;105,50;105,90;145,90])
add_line([sys,'/','Sinal T'],[175,95;195,95])


%     Finished composite block 'Sinal T'.

set_param([sys,'/','Sinal T'],...
		'position',[150,180,180,230])


%     Subsystem  ['vis 2',13,''].

new_system([sys,'/',['vis 2',13,'']])
set_param([sys,'/',['vis 2',13,'']],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/',['vis 2',13,'/x']])
set_param([sys,'/',['vis 2',13,'/x']],...
		'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['vis 2',13,'/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['vis 2',13,'/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfuny',...
		'parameters','ax, color,dt',...
		'position',[130,55,180,75])
add_line([sys,'/',['vis 2',13,'']],[90,65;125,65])
set_param([sys,'/',['vis 2',13,'']],...
		'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
		'Mask Type','Graph scope.')
set_param([sys,'/',['vis 2',13,'']],...
		'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/',['vis 2',13,'']],...
		'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/',['vis 2',13,'']],...
		'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/',['vis 2',13,'']],...
		'Mask Entries','0.01\/-10\/10\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['vis 2',13,''].

set_param([sys,'/',['vis 2',13,'']],...
		'position',[320,256,350,294])


%     Subsystem  'vis 3'.

new_system([sys,'/','vis 3'])
set_param([sys,'/','vis 3'],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/','vis 3/x'])
set_param([sys,'/','vis 3/x'],...
		'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['vis 3/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['vis 3/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfunyst',...
		'parameters','ax, color, npts, dt',...
		'position',[130,55,180,75])
add_line([sys,'/','vis 3'],[90,65;125,65])
set_param([sys,'/','vis 3'],...
		'Mask Display','plot(0,0,100,100,[83,76,63,52,42,38,28,16,11,84,11,11,11,90,90,11],[75,58,47,54,72,80,84,74,65,65,65,90,40,40,90,90])',...
		'Mask Type','Storage scope.')
set_param([sys,'/','vis 3'],...
		'Mask Dialogue','Storage scope using MATLAB graph window.\nEnter plotting ranges and line type.|Initial Time Range:|Initial y-min:|Initial y-max:|Storage pts.:|Line type (rgbw-.:xo):')
set_param([sys,'/','vis 3'],...
		'Mask Translate','npts = @4; color = @5; ax = [0, @1, @2, @3]; dt=-1;')
set_param([sys,'/','vis 3'],...
		'Mask Help','This block uses a MATLAB figure window to plot the input signal.  The graph limits are automatically scaled to the min and max values of the signal stored in the scope''s signal buffer.  Line type must be in quotes.  See the M-file sfunyst.m.')
set_param([sys,'/','vis 3'],...
		'Mask Entries','0.001\/-10\/10\/200\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'vis 3'.

set_param([sys,'/','vis 3'],...
		'position',[325,320,355,360])
add_line(sys,[185,205;240,205;240,220;315,220])
add_line(sys,[270,220;270,275;315,275])
add_line(sys,[270,275;270,340;320,340])

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

function [ret,x0,str,ts,xts]=espect(t,x,u,flag);
%ESPECT	is the M-file description of the SIMULINK system named ESPECT.
%	The block-diagram can be displayed by typing: ESPECT.
%
%	SYS=ESPECT(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes ESPECT to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling ESPECT with a FLAG of zero:
%	[SIZES]=ESPECT([],[],[],0),  returns a vector, SIZES, which
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
set_param(sys,'Min step size', '0.000001')
set_param(sys,'Max step size', '10')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Signal Generator',[sys,'/',['Signal',13,'Generator']])
set_param([sys,'/',['Signal',13,'Generator']],...
		'Peak','2.000000',...
		'Peak Range','5.000000',...
		'Freq','15.915500',...
		'Freq Range','5625.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[105,138,150,172])


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
		'Mask Entries','4\/-3\/3\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
		'position',[310,136,340,174])


%     Subsystem  'Average PSD'.

new_system([sys,'/','Average PSD'])
set_param([sys,'/','Average PSD'],'Location',[0,0,285,136])

add_block('built-in/S-Function',[sys,'/',['Average PSD/S-function block ',13,'which calls M-file']])
set_param([sys,'/',['Average PSD/S-function block ',13,'which calls M-file']],...
		'function name','sfunpsd',...
		'parameters','fftpts,npts,HowOften,offset,ts,1',...
		'position',[175,46,225,84])

add_block('built-in/Inport',[sys,'/','Average PSD/input signal'])
set_param([sys,'/','Average PSD/input signal'],...
		'position',[65,55,85,75])
add_line([sys,'/','Average PSD'],[90,65;170,65])
set_param([sys,'/','Average PSD'],...
		'Mask Display','plot(0,0,100,100,[11,92,92,11,11],[90,90,40,40,90],[82,76,65,57,51,44,35,30,25,20],[65,62,59,63,66,66,67,70,55,50])',...
		'Mask Type','Spectrum analyzer.')
set_param([sys,'/','Average PSD'],...
		'Mask Dialogue','Spectrum analyzer using graph window.|Length of buffer:|Number of points for fft:|Plot after how many points:|Sample time:')
set_param([sys,'/','Average PSD'],...
		'Mask Translate','npts=@1; fftpts=@2; HowOften=@3; ts=@4(1); if length(@4) > 1, offset = @4(2), else, offset = 0; end')
set_param([sys,'/','Average PSD'],...
		'Mask Help','This block when hooked to the output of a system displays the frequency content of the buffer in the graph window. For more see the M-file sfunpsd.',...
		'Mask Entries','128\/512\/64\/0.01\/')


%     Finished composite block 'Average PSD'.

set_param([sys,'/','Average PSD'],...
		'Drop Shadow',4,...
		'position',[315,227,345,263])
add_line(sys,[155,155;305,155])
add_line(sys,[190,155;190,245;310,245])

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

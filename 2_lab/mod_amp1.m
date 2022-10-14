function [ret,x0,str,ts,xts]=mod_amp1(t,x,u,flag);
%MOD_AMP1	is the M-file description of the SIMULINK system named MOD_AMP1.
%	MOD_AMP1 has a the following characteristics:
%		8 continuous states
%		3090 discrete states
%		0 outputs
%		0 inputs
%		does not have direct feedthrough
%		1 sample times
%
%	The block-diagram can be displayed by typing: MOD_AMP1.
%
%	SYS=MOD_AMP1(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes MOD_AMP1 to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling MOD_AMP1 with a FLAG of zero:
%	[SIZES]=MOD_AMP1([],[],[],0),  returns a vector, SIZES, which
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
set_param(sys,'Min step size', '0.01257')
set_param(sys,'Max step size', '0.0001')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Signal Generator',[sys,'/',['Signal',13,'Generator1']])
set_param([sys,'/',['Signal',13,'Generator1']],...
		'Peak','1.000000',...
		'Peak Range','5.000000',...
		'Freq','638.318500',...
		'Freq Range','5625.000000',...
		'Wave','Sin',...
		'Units','Rads',...
		'position',[310,248,355,282])

add_block('built-in/Product',[sys,'/','Product'])
set_param([sys,'/','Product'],...
		'position',[455,433,485,457])

add_block('built-in/Product',[sys,'/','Product1'])
set_param([sys,'/','Product1'],...
		'position',[575,454,600,476])

add_block('built-in/Sine Wave',[sys,'/','Sine Wave1'])
set_param([sys,'/','Sine Wave1'],...
		'frequency','6283.185',...
		'phase','1.570796',...
		'position',[440,510,455,530])


%     Subsystem  'Average PSD'.

new_system([sys,'/','Average PSD'])
set_param([sys,'/','Average PSD'],'Location',[0,0,285,136])

add_block('built-in/Inport',[sys,'/','Average PSD/input signal'])
set_param([sys,'/','Average PSD/input signal'],...
		'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Average PSD/S-function block ',13,'which calls M-file']])
set_param([sys,'/',['Average PSD/S-function block ',13,'which calls M-file']],...
		'function name','sfunpsd',...
		'parameters','fftpts,npts,HowOften,offset,ts,1',...
		'position',[175,46,225,84])
add_line([sys,'/','Average PSD'],[90,65;170,65])
set_param([sys,'/','Average PSD'],...
		'Mask Display','plot(0,0,100,100,[11,92,92,11,11],[90,90,40,40,90],[82,76,65,57,51,44,35,30,25,20],[65,62,59,63,66,66,67,70,55,50])',...
		'Mask Type','Spectrum analyzer.')
set_param([sys,'/','Average PSD'],...
		'Mask Dialogue','Spectrum analyzer using graph window.|Length of buffer:|Number of points for fft:|Plot after how many points:|Sample time:')
set_param([sys,'/','Average PSD'],...
		'Mask Translate','npts=@1; fftpts=@2; HowOften=@3; ts=@4(1); if length(@4) > 1, offset = @4(2), else, offset = 0; end')
set_param([sys,'/','Average PSD'],...
		'Mask Help','This block when hooked to the output of a system displays the frequency content of the buffer in the graph window. For more see the M-file sfunpsd.')
set_param([sys,'/','Average PSD'],...
		'Mask Entries','512\/2048\/64\/0.0001\/')


%     Finished composite block 'Average PSD'.

set_param([sys,'/','Average PSD'],...
		'Drop Shadow',4,...
		'position',[755,282,785,318])

add_block('built-in/Sine Wave',[sys,'/','Sine Wave'])
set_param([sys,'/','Sine Wave'],...
		'frequency','6283.185',...
		'phase','1.570796',...
		'position',[305,440,325,460])


%     Subsystem  'Graph3'.

new_system([sys,'/','Graph3'])
set_param([sys,'/','Graph3'],'Location',[0,59,274,252])

add_block('built-in/S-Function',[sys,'/',['Graph3/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Graph3/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfuny',...
		'parameters','ax, color,dt',...
		'position',[130,55,180,75])

add_block('built-in/Inport',[sys,'/','Graph3/x'])
set_param([sys,'/','Graph3/x'],...
		'position',[65,55,85,75])
add_line([sys,'/','Graph3'],[90,65;125,65])
set_param([sys,'/','Graph3'],...
		'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
		'Mask Type','Graph scope.')
set_param([sys,'/','Graph3'],...
		'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','Graph3'],...
		'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','Graph3'],...
		'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','Graph3'],...
		'Mask Entries','0.1\/-1.1\/1.2\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph3'.

set_param([sys,'/','Graph3'],...
		'position',[505,243,530,277])


%     Subsystem  'Graph1'.

new_system([sys,'/','Graph1'])
set_param([sys,'/','Graph1'],'Location',[0,59,274,252])

add_block('built-in/S-Function',[sys,'/',['Graph1/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Graph1/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfuny',...
		'parameters','ax, color,dt',...
		'position',[130,55,180,75])

add_block('built-in/Inport',[sys,'/','Graph1/x'])
set_param([sys,'/','Graph1/x'],...
		'position',[65,55,85,75])
add_line([sys,'/','Graph1'],[90,65;125,65])
set_param([sys,'/','Graph1'],...
		'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
		'Mask Type','Graph scope.')
set_param([sys,'/','Graph1'],...
		'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','Graph1'],...
		'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','Graph1'],...
		'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','Graph1'],...
		'Mask Entries','0.01\/-1.1\/1.2\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph1'.

set_param([sys,'/','Graph1'],...
		'position',[730,448,755,482])


%     Subsystem  'Average PSD1'.

new_system([sys,'/','Average PSD1'])
set_param([sys,'/','Average PSD1'],'Location',[0,0,285,136])

add_block('built-in/Inport',[sys,'/','Average PSD1/input signal'])
set_param([sys,'/','Average PSD1/input signal'],...
		'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Average PSD1/S-function block ',13,'which calls M-file']])
set_param([sys,'/',['Average PSD1/S-function block ',13,'which calls M-file']],...
		'function name','sfunpsd',...
		'parameters','fftpts,npts,HowOften,offset,ts,1',...
		'position',[175,46,225,84])
add_line([sys,'/','Average PSD1'],[90,65;170,65])
set_param([sys,'/','Average PSD1'],...
		'Mask Display','plot(0,0,100,100,[11,92,92,11,11],[90,90,40,40,90],[82,76,65,57,51,44,35,30,25,20],[65,62,59,63,66,66,67,70,55,50])',...
		'Mask Type','Spectrum analyzer.')
set_param([sys,'/','Average PSD1'],...
		'Mask Dialogue','Spectrum analyzer using graph window.|Length of buffer:|Number of points for fft:|Plot after how many points:|Sample time:')
set_param([sys,'/','Average PSD1'],...
		'Mask Translate','npts=@1; fftpts=@2; HowOften=@3; ts=@4(1); if length(@4) > 1, offset = @4(2), else, offset = 0; end')
set_param([sys,'/','Average PSD1'],...
		'Mask Help','This block when hooked to the output of a system displays the frequency content of the buffer in the graph window. For more see the M-file sfunpsd.')
set_param([sys,'/','Average PSD1'],...
		'Mask Entries','512\/2048\/64\/0.0001\/')


%     Finished composite block 'Average PSD1'.

set_param([sys,'/','Average PSD1'],...
		'Drop Shadow',4,...
		'position',[945,647,975,683])


%     Subsystem  'Graph2'.

new_system([sys,'/','Graph2'])
set_param([sys,'/','Graph2'],'Location',[0,59,274,252])

add_block('built-in/S-Function',[sys,'/',['Graph2/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Graph2/S-function',13,'M-file which plots',13,'lines',13,'']],...
		'function name','sfuny',...
		'parameters','ax, color,dt',...
		'position',[130,55,180,75])

add_block('built-in/Inport',[sys,'/','Graph2/x'])
set_param([sys,'/','Graph2/x'],...
		'position',[65,55,85,75])
add_line([sys,'/','Graph2'],[90,65;125,65])
set_param([sys,'/','Graph2'],...
		'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
		'Mask Type','Graph scope.')
set_param([sys,'/','Graph2'],...
		'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','Graph2'],...
		'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','Graph2'],...
		'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','Graph2'],...
		'Mask Entries','0.1\/-1.1\/1.2\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph2'.

set_param([sys,'/','Graph2'],...
		'position',[960,538,985,572])

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
		'Mask Entries','628.318\/40\/4\/',...
		'position',[735,529,795,571])
add_line(sys,[360,265;445,265;500,260])
add_line(sys,[330,450;450,450])
add_line(sys,[390,265;390,440;450,440])
add_line(sys,[460,520;470,520;570,470])
add_line(sys,[490,445;525,445;525,460;570,460])
add_line(sys,[605,465;725,465])
add_line(sys,[655,465;655,300;750,300])
add_line(sys,[665,465;665,550;730,550])
add_line(sys,[800,550;955,555])
add_line(sys,[860,552;860,665;940,665])

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

function handles = import_gui_ss(wzrd)
% page for setting specimen symmetry

pos = get(wzrd,'Position');
h = pos(4);
w = pos(3);
ph = 270;

handles = getappdata(wzrd,'handles');

this_page = get_panel(w,h,ph);
handles.pages = [handles.pages,this_page];
setappdata(this_page,'pagename','Set Specimen Geometry');

set(this_page,'visible','off');

scs = uibuttongroup('title','Specimen Coordinate System',...
  'Parent',this_page,...
  'units','pixels','position',[0 ph-140 w-20 130]);


uicontrol(...
 'Parent',scs,...
  'String','Symmetry',...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','left',...
  'Position',[10 80  100 15]);

handles.specime = uicontrol(...
  'Parent',scs,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','left',...
  'Position',[100 80 w-140 20],...
  'String',blanks(0),...
  'Style','popup',...
  'String',symmetries,...
  'Value',1);


handles.rotate = uicontrol(...
  'Parent',scs,...
  'Style','check',...
  'String','rotate around z-axis by ',...
  'Value',0,...
  'position',[10 40 180 20]);

handles.rotateAngle = uicontrol(...
  'Parent',scs,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','right',...
  'Position',[190 38 80 25],...
  'String','0',...
  'Style','edit');

uicontrol(...
  'Parent',scs,...
  'String','degree',...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','left',...
  'Position',[280 35 50 20]);

handles.flipud = uicontrol(...
  'Parent',scs,...
  'Style','check',...
  'String','flip upside down',...
  'Value',0,...
  'position',[10 10 160 20]);

handles.fliplr = uicontrol(...
  'Parent',scs,...
  'Style','check',...
  'String','flip left to right',...
  'Value',0,...
  'position',[190 10 120 20]);

uicontrol(...
  'String',['Use the plot command', ...
   'to verify that the specimen coordinate' ...
   ' system is aligned properly to the data!'],...
  'Parent',this_page,...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','left',...
  'Position',[5 0 390 30]);

plotg = uibuttongroup('title','Plotting Conventions',...
  'Parent',this_page,...
  'units','pixels','position',[0 40 w-20 80]);

uicontrol(...
 'Parent',plotg,...
 'String','x-axis direction:',...
 'HitTest','off',...
 'Style','text',...
 'HorizontalAlignment','left',...
 'Position',[20 20 100 20]);

uicontrol(...
 'Parent',plotg,...
 'String','West',...
 'HitTest','off',...
 'Style','text',...
 'HorizontalAlignment','right',...
 'Position',[125 20 50 20]);


handles.plot_dir(3) = uicontrol(...  
  'Parent',plotg,...
  'Style','radio',...
  'String','',...
  'Value',0,...
  'position',[180 23 20 20]);

handles.plot_dir(2) = uicontrol(...
  'Parent',plotg,...
  'Style','radio',...
  'String','North',...
  'Value',1,...
  'position',[200 42 80 20]);

handles.plot_dir(4) = uicontrol(...
  'Parent',plotg,...
  'Style','radio',...
  'String','South',...
  'Value',0,...
  'position',[200 5 80 20]);

handles.plot_dir(1) = uicontrol(...
  'Parent',plotg,...
  'Style','radio',...
  'String','East',...
  'Value',0,...
  'position',[220 23 80 20]);




% handles.plot_rotate = uicontrol(...
%   'Parent',plotg,...
%   'Style','check',...
%   'String','rotate around z-axis by ',...
%   'Value',0,...
%   'position',[10 40 180 20]);
%
%handles.plot_rotateAngle = uicontrol(...
%  'Parent',plotg,...
%  'BackgroundColor',[1 1 1],...
%  'FontName','monospaced',...
%  'HorizontalAlignment','right',...
%  'Position',[190 38 80 25],...
%  'String','0',...
%  'Style','edit');

%uicontrol(...
%  'Parent',plotg,...
%  'String','degree',...
%  'HitTest','off',...
%  'Style','text',...
%  'HorizontalAlignment','left',...
%  'Position',[280 35 50 20]);

%handles.plot_flipud = uicontrol(...
%  'Parent',plotg,...
%  'Style','check',...
%  'String','flip upside down',...
%  'Value',0,...
%  'position',[10 10 160 20]);

%handles.plot_fliplr = uicontrol(...
%  'Parent',plotg,...
%  'Style','check',...
%  'String','flip left to right',...
%  'Value',0,...
%  'position',[190 10 120 20]);

uicontrol(...
  'String',['Use the plot command', ...
   'to verify that the specimen coordinate' ...
   ' system is aligned properly to the data!'],...
  'Parent',this_page,...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','left',...
  'Position',[5 0 w-20 30]);

setappdata(this_page,'goto_callback',@goto_callback);
setappdata(this_page,'leave_callback',@leave_callback);
setappdata(wzrd,'handles',handles);


%% -------------- Callbacks ---------------------------------

function goto_callback(varargin)

get_ss(gcbf);
handles = getappdata(gcbf,'handles');

plot_options = get_mtex_option('default_plot_options');
value = get_option(plot_options,'rotate',0);
 
direction = 1+mod(round(2*(value) / pi),4);
   
set(handles.plot_dir(direction),'value',1);
% set(handles.plot_dir(1:4 ~= direction),'value',0);

% plot_options = get_mtex_option('default_plot_options');
% if check_option(plot_options,'rotate')
%   set(handles.plot_rotate,'value',1);
%   set(handles.plot_rotateAngle,'string',int2str(get_option(plot_options,'rotate',0)/degree));
% else
%   set(handles.plot_rotate,'value',0);
% end
% 
% if check_option(plot_options,'fliplr'), set(handles.plot_fliplr,'value',1);end
% if check_option(plot_options,'flipud'), set(handles.plot_flipud,'value',1);end

%  set(handles.comment,'String',get(appdata.data,'comment'));


function leave_callback(varargin)

set_ss(gcbf);
handles = getappdata(gcbf,'handles');

plot_options = get_mtex_option('default_plot_options');
plot_options = set_option(plot_options,'rotate',...
     (find(cell2mat(get(handles.plot_dir,'value')))-1)*pi/2);
set_mtex_option('default_plot_options',plot_options);

% plot_options = get_mtex_option('default_plot_options');
% if get(handles.plot_rotate,'value')
%   plot_options = set_option(plot_options,'rotate',...
%     str2double(get(handles.plot_rotateAngle,'string'))*degree);
% else
%   plot_options = delete_option(plot_options,'rotate');
% end
% if get(handles.plot_flipud,'value')
%   plot_options = set_option(plot_options,'flipud');
% else
%   plot_options = delete_option(plot_options,'flipud',0);
% end

% if get(handles.plot_fliplr,'value')
%   plot_options = set_option(plot_options,'fliplr');
% else
%   plot_options = delete_option(plot_options,'fliplr',0);
% end
% 
% 
% set_mtex_option('default_plot_options',plot_options);
%set(appdata.data,'comment',get(handles.comment,'String'));


%% ------------- Private Functions ------------------------------------------------

function set_ss(wzrd)
% set specimen symmetry

handles = getappdata(wzrd,'handles');
data = getappdata(wzrd,'data');

ss = symmetries(get(handles.specime,'Value'));
ss = strtrim(ss{1}(1:6));
ss = symmetry(ss);

% set data
data = set(data,'SS',ss);
setappdata(wzrd,'data',data);


function get_ss(wzrd)
% write ss to page

handles = getappdata(wzrd,'handles');
data = getappdata(wzrd,'data');

% get ss
ss = get(data,'SS');

% set specimen symmetry
ssname = strmatch(Laue(ss),symmetries);
set(handles.specime,'value',ssname(1));
 
 
%% ----------------------------------------------------------

% nv = uibuttongroup('title','Negative Values',...
%   'Parent',this_page,...
%   'units','pixels','position',[0 ph-210 380 100]);
% 
% uicontrol(...
%   'Parent',nv,...
%   'Style','radi',...
%   'String','keep negative values',...
%   'Value',1,...
%   'position',[10 60 160 20]);
% 
% handles.dnv = uicontrol(...
%   'Parent',nv,...
%   'Style','radi',...
%   'String','delete negative values',...
%   'Value',0,...
%   'position',[10 35 160 20]);
% 
% handles.setnv = uicontrol(...
%   'Parent',nv,...
%   'Style','radi',...
%   'String','set negative values to',...
%   'Value',0,...
%   'position',[10 10 160 20]);
% 
% handles.rnv = uicontrol(...
%   'Parent',nv,...
%   'BackgroundColor',[1 1 1],...
%   'FontName','monospaced',...
%   'HorizontalAlignment','right',...
%   'Position',[190 8 80 25],...
%   'String','0',...
%   'Style','edit');
% 
% 
% co = uibuttongroup('title','Comment',...
%   'Parent',this_page,...
%   'units','pixels','position',[0 0 380 54]);
% 
% handles.comment = uicontrol(...
%   'Parent',co,...
%   'BackgroundColor',[1 1 1],...
%   'FontName','monospaced',...
%   'HorizontalAlignment','left',...
%   'Position',[10 8 360 25],...
%   'String',blanks(0),...
%   'Style','edit');

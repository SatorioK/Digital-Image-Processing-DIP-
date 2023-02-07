function [lineobj,xs,ys] = drawline(varargin)
% 画线，用于标记前背景
% 左击开始，右击直接停止，双击闭合线后停止
% Brett Shoelson (2023). freehanddraw (https://www.mathworks.com/matlabcentral/fileexchange/7347-freehanddraw), MATLAB Central File Exchange.

% 输入参数验证
axdef = 0;
if nargin ~= 0 & ishandle(varargin{1})
	try
		axes(varargin{1});
		axdef = 1;
	catch
		error('If the initial input argument is a handle, it must be to a valid axis.');
	end
end
	
% 得到目前输入参数信息
oldvals = get(gcf);
oldhold = ishold(gca);
hold on;
set(gcf,'Pointer','crosshair','doublebuffer','on');
% 得到第一个输入点
[xs,ys] = ginput(1);
% 存储该线型标记
if axdef
	lineobj = line(xs,ys,'tag','tmpregsel',varargin{2:end});
else
	lineobj = line(xs,ys,'tag','tmpregsel',varargin{:});
end
setappdata(gcf,'lineobj',lineobj);
% 根据鼠标移动改变更新线型标记
set(gcf,'windowbuttonmotionfcn', @wbmfcn);
set(gcf,'windowbuttondownfcn', @wbdfcn);
% 等待右击或双击
while ~strcmp(get(gcf,'SelectionType'),'alt') & ~strcmp(get(gcf,'SelectionType'),'open')
	drawnow;
end
% 提取坐标信息
if nargout > 1
	xs = get(getappdata(gcf,'lineobj'),'xdata')';
end
if nargout > 2
	ys = get(getappdata(gcf,'lineobj'),'ydata')';
end
% 清除缓存量
evalin('caller','clear tmpx tmpy tmpz done gca lineobj');
% 重置各项参数
set(gcf,'Pointer',oldvals.Pointer,...
	'windowbuttonmotionfcn',oldvals.WindowButtonMotionFcn,...
    'windowbuttondownfcn',oldvals.WindowButtonDownFcn);...
% 重置停滞参数
if ~oldhold, hold off; end 
function wbmfcn(varargin)
lineobj = getappdata(gcf,'lineobj');
if strcmp(get(gcf,'selectiontype'),'normal')
    tmpx = get(lineobj,'xdata');
    tmpy = get(lineobj,'ydata');
    a=get(gca,'currentpoint');
    set(lineobj,'xdata',[tmpx,a(1,1)],'ydata',[tmpy,a(1,2)]);
    drawnow;
else
    setappdata(gcf,'lineobj',lineobj);
end
function wbdfcn(varargin)
lineobj = getappdata(gcf,'lineobj');
if strcmp(get(gcf,'selectiontype'),'open')
    tmpx = get(lineobj,'xdata');
    tmpy = get(lineobj,'ydata');
    get(gca,'currentpoint');
    set(lineobj,'xdata',[tmpx,tmpx(1)],'ydata',[tmpy,tmpy(1)]);
    setappdata(gcf,'lineobj',lineobj);
    drawnow;
end
return

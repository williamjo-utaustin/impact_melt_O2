function varargout = fig_set(p,fontsize,fig_name)

% Author: C. Sun
% Data: $ 2011-01-?  $
% Data: $ 2011-05-18 $
% Data: $ 2020-04-29 $

if nargin<1
    p(1) = 1;
    p(2) = 1;
    fontsize = 15;
    fig_name = '';
elseif nargin <2
    fontsize = 15;
    fig_name = '';
elseif nargin ==2
    fig_name = '';
end

if length(fontsize)==2
    lw = fontsize(2);
    fontsize = fontsize(1);
    ms = 8;
    tl = 0.025;
elseif length(fontsize)==3
    ms = fontsize(3);
    lw = fontsize(2);
    fontsize = fontsize(1);
    tl = 0.025;
elseif length(fontsize)==4
    tl = fontsize(4);
    ms = fontsize(3);
    lw = fontsize(2);
    fontsize = fontsize(1);
elseif length(fontsize)==1
    lw = 1.5;
    ms = 8;
    tl = 0.025;
end

scrsz = get(0,'ScreenSize');
pixperinch = get(0,'ScreenPixelsPerInch');
h1=figure('Name',fig_name,'NumberTitle','off',...
          'Position',[scrsz(3)/20 scrsz(4)/20 pixperinch*p(1) pixperinch*p(2)]);
set(gcf,'color','white',...
     'DefaultAxesLineWidth',lw,...
     'DefaultLineLineWidth',lw,...
     'DefaultLineMarkersize',ms,...
     'DefaultTextFontSize',fontsize,...
     'defaultaxesfontsize',fontsize,...
     'DefaultAxesTickLength',[tl tl],...
     'defaultaxesfontname','Arial');
if nargout==0
    varargout = {};
elseif nargout==1
    varargout(1)={h1};
end
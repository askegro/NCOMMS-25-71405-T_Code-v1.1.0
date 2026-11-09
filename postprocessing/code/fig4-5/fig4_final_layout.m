function fig4_final_layout(shiftPt)
% FIG4_FINAL_LAYOUT  Re-export Fig. 4 from its saved .fig with the final layout.
% Called by run_all_figures after Fig4_5_SuppFig3_SuppFig4. Runs in seconds and
% does not recompute any results. It
%   1. restores the figure size used by the main script (18 x 14 cm), so the
%      layout and spacing match the original Fig. 4;
%   2. sets a little headroom above the curves in panels (b)-(d):
%      (b) and (d) [0 65] kEUR, (c) [5 22] kEUR (ticks unchanged up to 60 / 20);
%   3. removes the break-even marker where the RBP ends up more expensive;
%   4. moves the legends of panels (b)-(d) SHIFTPT points (default 5.5 pt,
%      about 1.9 mm) up and to the left of their default 'northwest' position.
if nargin < 1 || isempty(shiftPt), shiftPt = 5.5; end
resDir = fullfile(fileparts(fileparts(fileparts(mfilename('fullpath')))), ...
                  'results', 'fig4-5');
f = openfig(fullfile(resDir, 'J1_NatComm_Figure_4.fig'), 'new', 'visible');

% 1. figure size as in Fig4_5_SuppFig3_SuppFig4.m
paperWidth = 18.0; paperHeight = 14.0;
set(f, 'Units', 'centimeters', 'Position', [2 2 paperWidth paperHeight], ...
    'PaperUnits', 'centimeters', 'PaperSize', [paperWidth paperHeight], ...
    'PaperPosition', [0 0 paperWidth paperHeight], 'PaperPositionMode', 'manual');
drawnow;

% 2. y-axis headroom in panels (b)-(d): the axes with 'NPC [kEUR]' labels,
%    ordered left to right
ax = findobj(f, 'Type', 'axes');
ax = ax(arrayfun(@(h) strcmp(h.YLabel.String, 'NPC [kEUR]'), ax));
[~, order] = sort(arrayfun(@(h) h.Position(1), ax)); ax = ax(order);
if numel(ax) == 3
    ylim(ax(1), [0 65]); yticks(ax(1), [0 20 40 60]);   % (b) best
    ylim(ax(2), [5 22]); yticks(ax(2), [5 10 15 20]);   % (c) baseline
    ylim(ax(3), [0 65]); yticks(ax(3), [0 20 40 60]);   % (d) worst
else
    warning('Fig4:axes', 'Expected 3 NPC axes, found %d; y-limits not changed.', numel(ax));
end

% 3. no break-even in a panel whose RBP ends up more expensive (the worst
%    case): remove the marker and write 'Break-even: -- years', as the main
%    script does when there is no crossing
colCBP = [86 180 233] / 255;
for k = 1:numel(ax)
    L = findobj(ax(k), 'Type', 'line');
    curves = L(arrayfun(@(h) numel(h.XData) > 2, L));
    isCBP = arrayfun(@(h) max(abs(h.Color - colCBP)) < 1e-3, curves);
    if nnz(isCBP) ~= 1 || numel(curves) ~= 2, continue; end
    dEnd = curves(isCBP).YData(end) - curves(~isCBP).YData(end);
    if dEnd <= 0
        delete(findobj(ax(k), 'Type', 'line', 'Marker', 'x'));
        T = findobj(ax(k), 'Type', 'text');
        for t = T(:)'
            t.String = regexprep(t.String, 'Break-even: [0-9.]+ years', 'Break-even: -- years');
        end
        fprintf('Panel %d: RBP ends %.2f kEUR more expensive; break-even marker removed.\n', k, -dEnd);
    end
end

% 4. legends of panels (b)-(d)
lg = findobj(f, 'Type', 'legend');
lg = lg(arrayfun(@(h) numel(h.String) <= 5, lg));   % panels (b)-(d), not (a)
for k = 1:numel(lg), lg(k).Location = 'northwest'; end
drawnow;
for k = 1:numel(lg)
    lg(k).Units = 'points';     p = lg(k).Position;
    lg(k).Units = 'normalized'; n = lg(k).Position;
    sx = n(3) / p(3);  sy = n(4) / p(4);
    lg(k).Position = [n(1) - shiftPt*sx, n(2) + shiftPt*sy, n(3), n(4)];
end
drawnow;
exportgraphics(f, fullfile(resDir, 'J1_NatComm_Figure_4.pdf'), 'ContentType', 'vector', 'BackgroundColor', 'white');
exportgraphics(f, fullfile(resDir, 'J1_NatComm_Figure_4.eps'), 'ContentType', 'vector', 'BackgroundColor', 'white');
fprintf('Fig. 4 re-exported to %s\n', resDir);
end

function [ui] = create_ui()

f = figure;
ui = uicontrol(f, 'Style', 'PushButton', ...
               'String', 'Terminar rutina', ...
               'Callback', 'delete(gcbf)', ...
               'Position',[200 200 180 60]);

end


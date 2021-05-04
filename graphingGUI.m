function [] = GraphingGUI()
global graph;

graph.fig = figure('numbertitle', 'off', 'name', 'Plot Graph');


graph.run = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.3 .85 .05 .05], 'Callback', {@plotting});
graph.runLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.25 .84 .05 .05], 'string', 'Run', 'horizontalalignment', 'left');
%Plots the inputs

graph.reset = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.5 .85 .05 .05], 'Callback', {@clearPlot});
graph.resetLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.45 .84 .05 .05], 'string', 'Reset', 'horizontalalignment', 'left');
%clears the graph and input boxes.


graph.xinputLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.01 .95 .20 .05], 'string', 'x values:', 'horizontalalignment', 'left');
graph.xinput = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.01 .90 .10 .05]);
%box to put x data

graph.yinputLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.01 .85 .20 .05], 'string', 'y values:', 'horizontalalignment', 'left');
graph.yinput = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.01 .80 .10 .05]);
%box to put y data

graph.xmin = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.1 .2 .05 .05]);
graph.xmax = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.1 .25 .05 .05]);
graph.ymin = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.1 .3 .05 .05]);
graph.ymax = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.1 .35 .05 .05]);
%boxes to change the graph limits

graph.xminLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.02 .20 .07 .05], 'string', 'x min:', 'horizontalalignment', 'right');
graph.xmaxLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.02 .25 .07 .05], 'string', 'x max:', 'horizontalalignment', 'right');
graph.yminLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.02 .30 .07 .05], 'string', 'y min:', 'horizontalalignment', 'right');
graph.ymaxLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.02 .35 .07 .05], 'string', 'y max:', 'horizontalalignment', 'right');
%labels the limit input boxes

graph.buttonGroupColor = uibuttongroup ('Visible', 'on', 'units', 'normalized', 'position', [.85 .6 .15 .2]);
graph.r1 = uicontrol(graph.buttonGroupColor, 'style', 'radiobutton', 'string', 'k', 'units', 'normalized', 'position', [.1 .5 .3 .2], 'HandleVisibility', 'off');
graph.r2 = uicontrol(graph.buttonGroupColor, 'style', 'radiobutton', 'string', 'm', 'units', 'normalized', 'position', [.1 .25 .3 .2], 'HandleVisibility', 'off');
graph.r3 = uicontrol(graph.buttonGroupColor, 'style', 'radiobutton', 'string', 'c', 'units', 'normalized', 'position', [.1 .05 .3 .2], 'HandleVisibility', 'off');
%makes a button group to change the color

graph.buttonGroupStyle = uibuttongroup('Visible', 'on', 'units', 'normalized', 'position', [.85 .2 .15 .2]);
graph.b1 = uicontrol(graph.buttonGroupStyle, 'style', 'radiobutton', 'string', '-', 'units', 'normalized', 'position', [.1 .5 .4 .3], 'HandleVisibility', 'off');
graph.b2 = uicontrol(graph.buttonGroupStyle, 'style', 'radiobutton', 'string', ':', 'units', 'normalized', 'position', [.1 .25 .3 .3], 'HandleVisibility', 'off');
graph.b3 = uicontrol(graph.buttonGroupStyle, 'style', 'radiobutton', 'string', '--', 'units', 'normalized', 'position', [.1 .02 .4 .3], 'HandleVisibility', 'off');
%makes a button group to change the line type

graph.titleLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.25 .7 .20 .05], 'string', 'Title:');
graph.title = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.4 .71 .10 .05]);
%box to title the graph

graph.xaxisLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.26 .08 .20 .05], 'string', 'x Axis:');
graph.xaxis = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.4 .09 .10 .05]);
%box to label the x axis

graph.yaxisLabel = uicontrol('style', 'text', 'units', 'normalized', 'position', [.7 .45 .1 .05], 'string', 'y Axis:');
graph.yaxis = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.79 .46 .10 .05]);
%box to label the y axis

graph.p = plot (0,0);
graph.p.Parent.Units = 'Normalized';
graph.p.Parent.Position = [0.2 0.2 0.5 0.5];
%makes an empty graph when the figure opens

    function [] = plotting(~,~)
        if length(graph.xinput) == 0 || length(graph.yinput) == 0
            %checks if there are the same number of inputs
            
            return;
            
        end
        xVals = str2num(graph.xinput.String);
        
        yVals = str2num(graph.yinput.String);
        %Changes the user input from strings to numbers
        
        
        expOne = '[0-9]*(\.[0-9])?(,[0-9])?';
        
        resultX = regexp(graph.xinput.String, expOne, 'match');
        
        resultY = regexp(graph.yinput.String, expOne, 'match');
        %makes sure the inputs are all numbers
        
        if length(xVals) ~= length(yVals)
            
            msgbox('Invalid Input!', 'Plotting Error', 'error', 'modal');
            %displays a message that the inputs are wrong
            
            return;
            
        elseif length(resultX) == 0 || length(resultY) == 0
  
            msgbox('Invalid Inputs.', 'Plotting Error', 'error', 'modal');
            %displays a message that the inputs are wrong
            
            return;            
            
        else
            
          lineColor = graph.buttonGroupColor.SelectedObject.String;
          
          lineStyle = graph.buttonGroupStyle.SelectedObject.String;
           
          %makes the line color and type into variables
          
          graph.p = plot(xVals, yVals, [lineColor lineStyle]);
          %plots all of the inputs
          
        end
                  
        
        
        
           expTwo = '[0-9]*(\.[0-9])?';
        resultXmin = regexp(graph.xmin.String, expTwo, 'match');
        resultXmax = regexp(graph.xmax.String, expTwo, 'match');
     %makes sure the mins and max inputs are real numbers
        
        if length(graph.xmin.String) == 0 || length(graph.xmax.String) == 0
    
            return;
         
        end
        
       if str2num(graph.xmax.String) < str2num(graph.xmin.String)
           
          msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
       
          %If the max is smaller that the min that was input, it gives an
          %error
          
           return;
           
       elseif length(resultXmin) == 0 || length(resultXmax) == 0
            msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
            %if the inputs are not real numbers it gives an error
            
            return;
           
            
       else 
           
            xMinimum = str2double(graph.xmin.String);
            
            xMaximum = str2double(graph.xmax.String);
            
            xlim([xMinimum, xMaximum]);
            %plots the max and min
            
       end

       
       
                  expThree = '[0-9]*(\.[0-9])?';
        resultYmin = regexp(graph.ymin.String, expThree, 'match');
        resultYmax = regexp(graph.ymax.String, expThree, 'match');
      %makes sure the mins and max are real numbers
       
               if length(graph.ymin.String) == 0 || length(graph.ymax.String) == 0
          
                   return;
        end
        
       if str2num(graph.ymax.String) < str2num(graph.ymin.String)
          msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
        
          %if the max is smaller than the min that was input, it gives an
          %error
          
           return;
           
       elseif length(resultYmin) == 0 || length(resultYmax) == 0
           msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
    %if the max or min are not real numbers it gives an error
    
           return;
          
       else 
            yMinimum = str2double(graph.ymin.String);
            
            yMaximum = str2double(graph.ymax.String);
            
            ylim([yMinimum, yMaximum]);
            %graphs the min and max
            
       end
      
                   
    end


    function [] = clearPlot(~,~)
        graph.p = plot(0,0);
        graph.xinput.String = '';
        graph.yinput.String = '';
        graph.xmin.String = '';
        graph.xmax.String = '';
        graph.ymin.String = '';
        graph.ymax.String = '';
        graph.xaxis.String = '';
        graph.yaxis.String = '';
        graph.title.String = '';
       %clears the plot and all the input boxes
       
    end
        
end
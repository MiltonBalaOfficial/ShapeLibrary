-- Register Toolbar actions and initialize UI stuff
      function initUi()
        app.registerUi({["menu"] = "Insert Shapes", ["callback"] = "showMainShapeDialog", ["accelerator"] = "<Control><Alt>3", ["toolbarId"] = "shapedialog", ["iconName"] = "shapes_symbolic"})   
      end

-- Function to display the main shape-type selection dialog
      function showMainShapeDialog()
        app.openDialog("Choose a catagory of shapes to insert:", {"Geometric-2D", "Geometric-3D", "Axix-System", "Graphs", "Cancel"}, "mainShapeDialogCallback")
      end

          -- Callback function to handle button clicks in the main shape dialog
              function mainShapeDialogCallback(result)
                  if result == 1 then
                      geometricTwoDimensional()
                    elseif result == 2 then
                      geometricThreeDimensional()
                    elseif result == 3 then
                      axisSystem()
                    elseif result == 4 then
                      graphfunctions()
                  end
              end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Common codes for getting the file and making the stroke data formatted
    -- Getting folder Path
            local folderpathGeometric_2D = "C:\\Program Files\\Xournal++\\share\\xournalpp\\plugins\\Quick Shape Library\\Shapes\\Geometric_2D\\"
            local folderpathGeometric_3D = "C:\\Program Files\\Xournal++\\share\\xournalpp\\plugins\\Quick Shape Library\\Shapes\\Geometric_3D\\"
            local folderpathAxixSystem = "C:\\Program Files\\Xournal++\\share\\xournalpp\\plugins\\Quick Shape Library\\Shapes\\Axix_System\\"
            local folderpathGraphs = "C:\\Program Files\\Xournal++\\share\\xournalpp\\plugins\\Quick Shape Library\\Shapes\\Graphs\\"

    -- Shared function to read and format stroke data from a file
            function read_strokes_from_file(filepath)
              local file = io.open(filepath, "r")
            
              local content = file:read("*all")
                              file:close()
            
              local strokesData, err = load(content)
            
              strokesData = strokesData()
              local strokesToAdd = {}
            
              for _, stroke in pairs(strokesData) do
                if type(stroke) == "table" and stroke.x and stroke.y then
                  local newStroke = {
                    x = stroke.x,
                    y = stroke.y,
                    pressure = stroke.pressure,
                    tool = stroke.tool or "pen",
                    color = stroke.color or 0,
                    width = stroke.width or 1,
                    fill = stroke.fill or 0,
                    lineStyle = stroke.lineStyle or "plain"
                  }
                  table.insert(strokesToAdd, newStroke)
                end
              end
            
              return strokesToAdd -- formatted strokes data for adding
            end


-- All codes for inserting 2D Shapes
  ----------------------------------
    -- Secondary Dialog for Shape Options (Geometric Two Dimensional Shapes)

        function geometricTwoDimensional()
          app.openDialog("Geometric Two Dimensional Shapes", {"Arrowhead", "Triangle", "Equilateral Triangle", "Right Angle Triangle", "Back" }, "geometricTwoDimensionalCallback")
        end

            -- Callback for the Shape-1 Options Dialog (Geometric Two Dimensional Shapes)
               function geometricTwoDimensionalCallback(result)
                  if result == 1 then
                       qshape_Arrowhead()
                     elseif result == 2 then
                       qshape_Triangle()
                      elseif result == 3 then
                        qshape_Equi_Triangle()
                      elseif result == 4 then
                        qshape_RightAngleTriangle()
                      elseif result == 5 then
                        showMainShapeDialog()  -- Return to the main shape dialog
                  end
               end

  
    -- All Strokes for Geometric-2D Shapes

        -- Callback for inserting arrowhead
              function qshape_Arrowhead()  local filepath = folderpathGeometric_2D .. "ArrowHead.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end
    
        -- Callback for inserting triangle
            function qshape_Triangle()
              local filepath = folderpathGeometric_2D .. "ScaleneTriangle.lua"
              local strokes = read_strokes_from_file(filepath)
              if strokes and #strokes > 0 then
                app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                app.refreshPage()
              end
            end
            
        -- Callback for inserting equilateral triangle
              function qshape_Equi_Triangle()
                local filepath = folderpathGeometric_2D .. "EquilateralTriangle.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end    

        -- Callback for inserting right-angle isosceles triangle
              function qshape_RightAngleTriangle()  local filepath = folderpathGeometric_2D .. "RightAngleTriangle.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end

-- All codes for inserting 3D Geometrical shapes 
  ------------------------------------------------ 

    -- Secondary Dialog for Shape Options (Geometric 3D Shapes)
        function geometricThreeDimensional()
          app.openDialog("Geometric Three Dimensional Shapes", {"Cube", "Cylinder", "Sphere", "Hemisphere", "Cone", "Dish", "Back" }, "geometricThreeDimensionalCallback")
        end

            -- Callback for the Shape-1 Options Dialog (Geometric Two Dimensional Shapes)
               function geometricThreeDimensionalCallback(result)
                  if result == 1 then
                        drawCube()
                      elseif result == 2 then
                        drawCylinder()
                      elseif result == 3 then
                        drawSphere()
                      elseif result == 4 then
                        drawHemisphere()
                      elseif result == 5 then
                        drawCone()
                      elseif result == 6 then
                        drawTumbler()
                      elseif result == 7 then
                        showMainShapeDialog()  -- Return to the main shape dialog
                  end
               end

    -- All Strokes for Geometric-3D Shapes
       
        -- Callback for inserting Cube
                  function drawCube()  local filepath = folderpathGeometric_3D .. "Cube.lua"
                    local strokes = read_strokes_from_file(filepath)
                    if strokes and #strokes > 0 then
                      app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                      app.refreshPage()
                    end
                  end
                            
                
        -- Callback for incerting a Cylinder
              function drawCylinder()  local filepath = folderpathGeometric_3D .. "Cylender.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end

        -- Callback for inserting Sphere
              function drawSphere()  local filepath = folderpathGeometric_3D .. "Sphere.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end

        -- Callback for inserting Hemisphere      
              function drawHemisphere()  local filepath = folderpathGeometric_3D .. "Hemisphere.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end 

        -- Callback for inserting Cone      
              function drawCone()  local filepath = folderpathGeometric_3D .. "Cone.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end 

        -- Callback for inserting tumbler
               function drawTumbler()  local filepath = folderpathGeometric_3D .. "Tumbler.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end 
-- All codes for inserting different types of axis
  ------------------------------------------------
    -- Secondary Dialog for Shape Options (Different types of axix)
        function axisSystem()
          app.openDialog("Axis-System", {"1st Quad", "1st & 2nd Quad", "1st & 4th Quad", "Full Axis", "Full Axis with Grids", "Back"}, "axisSystemCallback")
        end

            -- Callback for the Different types of axix Dialog
               function axisSystemCallback(result)
                  if result == 1 then
                       positiveXYAxix()
                     elseif result == 2 then
                       firstAndSecondQuadrant()
                      elseif result == 3 then
                        firstAndFourthQuadrant()
                      elseif result == 4 then
                        fullAxix()
                      elseif result == 5 then
                        GraphGrids()
                      elseif result == 6 then
                        showMainShapeDialog()  -- Return to the main shape dialog
                  end
               end

 -- All strokes for different types of axis

      -- Callback for option-1 (Positive XY axis)
              function positiveXYAxix()  local filepath = folderpathAxixSystem .. "1st_Quad.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end 
          
      -- Callback for option-2 (first and second quadrant)
              function firstAndSecondQuadrant()  local filepath = folderpathAxixSystem .. "1st&2nd_Quad.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end 
          
      -- Callback for option-3 (first and fourth quadrant)
              function firstAndFourthQuadrant()  local filepath = folderpathAxixSystem .. "1st&4th_Quad.lua"
                local strokes = read_strokes_from_file(filepath)
                if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                  app.refreshPage()
                end
              end 
          
      -- Callback for option-4 (Full axis)        
                function fullAxix()  local filepath = folderpathAxixSystem .. "Full_Axis.lua"
                  local strokes = read_strokes_from_file(filepath)
                  if strokes and #strokes > 0 then
                    app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                    app.refreshPage()
                  end
                end 

      -- Callback for option-5 (full axis with Grids) 
                function GraphGrids()  local filepath = folderpathAxixSystem .. "Full_with_Grids.lua"
                  local strokes = read_strokes_from_file(filepath)
                  if strokes and #strokes > 0 then
                    app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                    app.refreshPage()
                  end
                end 



-- All codes for inserting different types of graphs
  --------------------------------------------------
    -- Secondary Dialog for Shape Option: (Graphs) 
        function graphfunctions()
          app.openDialog("Different Types of Graphs", {"Sin x", "cos x", "(sin x)^2", "(cos x)^2", "| sin x |", "| cos x |", "Back" }, "graphTypesCallback")
        end

        -- Callback for the Different types of graphs Dialog
            function graphTypesCallback(result)
               if result == 1 then
                    qshape_sinx()
                  elseif result == 2 then
                    qshape_cosx()
                  elseif result == 3 then
                    qshape_sinSqx()
                  elseif result == 4 then
                    qshape_cosSqx()
                  elseif result == 5 then
                    qshape_mode_sinx()
                  elseif result == 6 then
                    qshape_mode_cosx()
                  elseif result == 7 then
                    showMainShapeDialog()  -- Return to the main shape dialog
               end
            end
   
     
     --All strokes for Shape Option - Graphs

            -- Callback for inserting grapg of sin x
                  function qshape_sinx()  local filepath = folderpathGraphs .. "sinx.lua"
                    local strokes = read_strokes_from_file(filepath)
                    if strokes and #strokes > 0 then
                      app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                      app.refreshPage()
                    end
                  end 

            -- Callback for inserting grapg of cos x
                   function qshape_cosx()  local filepath = folderpathGraphs .. "cosx.lua"
                    local strokes = read_strokes_from_file(filepath)
                    if strokes and #strokes > 0 then
                      app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                      app.refreshPage()
                    end
                  end 


            -- Callback for inserting grapg of sin^2 x
                  function qshape_sinSqx()  local filepath = folderpathGraphs .. "sinSqx.lua"
                    local strokes = read_strokes_from_file(filepath)
                    if strokes and #strokes > 0 then
                      app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                      app.refreshPage()
                    end
                  end 

            -- Callback for inserting grapg of cos^2 x
                  function qshape_cosSqx()  local filepath = folderpathGraphs .. "cosSqx.lua"
                    local strokes = read_strokes_from_file(filepath)
                    if strokes and #strokes > 0 then
                      app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                      app.refreshPage()
                    end
                  end 

            -- Callback for inserting grapg of mod of sinx
                      function qshape_mode_sinx()  local filepath = folderpathGraphs .. "Mod_sinx.lua"
                        local strokes = read_strokes_from_file(filepath)
                        if strokes and #strokes > 0 then
                          app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                          app.refreshPage()
                        end
                      end 
            -- Callback for inserting grapg of mod of cos x
                  function qshape_mode_cosx()  local filepath = folderpathGraphs .. "Mod_cosx.lua"
                    local strokes = read_strokes_from_file(filepath)
                    if strokes and #strokes > 0 then
                      app.addStrokes({ strokes = strokes }, {allowUndoRedoAction = "grouped"})
                      app.refreshPage()
                    end
                  end 
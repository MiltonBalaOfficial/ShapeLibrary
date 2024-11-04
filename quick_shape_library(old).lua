-- Register Toolbar actions and initialize UI stuff
      function initUi()
        app.registerUi({["menu"] = "Insert Shapes", ["callback"] = "showMainShapeDialog", ["accelerator"] = "<Control><Alt>3", ["toolbarId"] = "shapedialog", ["iconName"] = "shapes_symbolic"})   
     
        -- Getting the source folder Path
             local sep = package.config:sub(1, 1) -- path separator depends on OS
             sourcePath = debug.getinfo(1).source:match("@?(.*" .. sep .. ")")
      end

-- Function to display the main shape-type selection dialog
      function showMainShapeDialog()
        app.openDialog("Choose a catagory of shapes to insert:", {"Geometric-2D", "Geometric-3D", "Axis-System", "Graphs", "Physics Diagram", "Cancel"}, "mainShapeDialogCallback")
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
                    elseif result == 5 then
                      physicsDiagram()
                  end
              end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Common codes for getting the file and making the stroke data formatted
    
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

-- Shared Function to insert strokes for a shape
            function insert_shape(shape_name)
              local filepath = sourcePath .. "Shapes" .. package.config:sub(1, 1) .. shape_name .. ".lua"
              local strokes = read_strokes_from_file(filepath)
              if strokes and #strokes > 0 then
                  app.addStrokes({ strokes = strokes }, { allowUndoRedoAction = "grouped" })
                  app.refreshPage()
              end
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

        -- Callback for inserting arrowhead
              function qshape_Arrowhead()
                insert_shape("ArrowHead")
              end

        -- Callback for inserting triangle
              function qshape_Triangle()
                insert_shape("ScaleneTriangle")
              end

        -- Callback for inserting equilateral triangle
              function qshape_Equi_Triangle()
                insert_shape("EquilateralTriangle")
              end

        -- Callback for inserting right-angle isosceles triangle
              function qshape_RightAngleTriangle()
                insert_shape("RightAngleTriangle") 
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
    
        -- Callback for inserting Cube
              function drawCube()
                insert_shape("Cube") 
              end   
                
        -- Callback for incerting a Cylinder
              function drawCylinder()
                insert_shape("Cylinder") 
              end

        -- Callback for inserting Sphere
              function drawSphere()  
                insert_shape("Sphere") 
              end

        -- Callback for inserting Hemisphere      
              function drawHemisphere()
                insert_shape("Hemisphere")  
              end     

        -- Callback for inserting Cone      
              function drawCone()
                insert_shape("Cone")  
              end 

        -- Callback for inserting tumbler
              function drawTumbler()
                insert_shape("Tumbler") 
              end 

-- All codes for inserting different types of axis
  ------------------------------------------------
    -- Secondary Dialog for Shape Options (Different types of axis)
        function axisSystem()
          app.openDialog("Axis-System", {"1st Quad", "1st & 2nd Quad", "1st & 4th Quad", "Full Axis", "Full Axis with Grids", "Back"}, "axisSystemCallback")
        end

            -- Callback for the Different types of axis Dialog
               function axisSystemCallback(result)
                  if result == 1 then
                       positiveXYAxis()
                     elseif result == 2 then
                       firstAndSecondQuadrant()
                      elseif result == 3 then
                        firstAndFourthQuadrant()
                      elseif result == 4 then
                        fullAxis()
                      elseif result == 5 then
                        GraphGrids()
                      elseif result == 6 then
                        showMainShapeDialog()  -- Return to the main shape dialog
                  end
               end

      -- Callback for option-1 (Positive XY axis)
              function positiveXYAxis()
                insert_shape("1st_Quad")
              end 
          
      -- Callback for option-2 (first and second quadrant)
              function firstAndSecondQuadrant()
                insert_shape("1st&2nd_Quad")
              end 
              
      -- Callback for option-3 (first and fourth quadrant)
              function firstAndFourthQuadrant()
                insert_shape("1st&4th_Quad")
              end 
          
      -- Callback for option-4 (Full axis)        
                function fullAxis()
                  insert_shape("Full_Axis")
                end 

      -- Callback for option-5 (full axis with Grids) 
                function GraphGrids()
                  insert_shape("Full_with_Grids")
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
     
      -- Callback for inserting grapg of sin x
            function qshape_sinx()
              insert_shape("sinx")
            end 

    -- Callback for inserting grapg of cos x
            function qshape_cosx()
              insert_shape("cosx")
            end 

      -- Callback for inserting grapg of sin^2 x
            function qshape_sinSqx()
              insert_shape("sinSqx")
            end 

      -- Callback for inserting grapg of cos^2 x
            function qshape_cosSqx()
              insert_shape("cosSqx")
            end 

      -- Callback for inserting grapg of mod of sinx
            function qshape_mode_sinx()
              insert_shape("Mod_sinx")
            end 

      -- Callback for inserting grapg of mod of cos x
            function qshape_mode_cosx()
              insert_shape("Mod_cosx")
            end

-- All codes for inserting different types of Physics Diagram
  --------------------------------------------------
    -- Secondary Dialog for Shape Option: (Physics Diagram) 
    function physicsDiagram()
      app.openDialog("Different Types of diagram used in physics", {"Spring", "immovable Support", "Circuit-1", "Circuit-2", "Circuit-3", "Circuit-4", "Back" }, "physicsDiagramCallback")
    end

    -- Callback for the Different types of Physics-Diagram
        function physicsDiagramCallback(result)
           if result == 1 then
                spring()
              elseif result == 2 then
                opt1()
              elseif result == 3 then
                opt2()
              elseif result == 4 then
                opt3()
              elseif result == 5 then
                opt4()
              elseif result == 6 then
                opt5()
              elseif result == 7 then
                showMainShapeDialog()  -- Return to the main shape dialog
           end
        end
 
  -- Callback for inserting diagram of spring
        function spring()
          insert_shape("Spring")
        end 

  -- Callback for inserting diagram of Immovable Support (example function)
        function immovableSupport()
          insert_shape("ImmovableSupport")
        end

  -- Example callback functions for circuits (you can define these accordingly)
      function circuit1()
        insert_shape("Circuit1")
      end

      function circuit2()
        insert_shape("Circuit2")
      end
    
      function circuit3()
        insert_shape("Circuit3")
      end
    
      function circuit4()
        insert_shape("Circuit4")
      end
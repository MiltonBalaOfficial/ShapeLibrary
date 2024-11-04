-- Register Toolbar actions and initialize UI stuff
      function initUi()
        app.registerUi({["menu"] = "Insert Shapes", ["callback"] = "showMainShapeDialog", ["accelerator"] = "<Control><Alt>3", ["toolbarId"] = "shapedialog", ["iconName"] = "shapes_symbolic"})   
     
        -- Getting the source folder Path (The plugin folder-path)
             local sep = package.config:sub(1, 1) -- path separator depends on OS
             sourcePath = debug.getinfo(1).source:match("@?(.*" .. sep .. ")")
      end

-- Function to read and provide formatted stroke data from a file
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


-- Function to insert strokes for a shape (need to extract the shape name from the dictionary)
      function insert_stroke(shape_name)
        local filepath = sourcePath .. "Shapes" .. package.config:sub(1, 1) .. shape_name .. ".lua"
        local strokes = read_strokes_from_file(filepath)
        if strokes and #strokes > 0 then
            app.addStrokes({ strokes = strokes }, { allowUndoRedoAction = "grouped" })
            app.refreshPage()
        end
      end


-- The dictionary for shapes (If you need extra shapes, just put the shape file (Shape.lua) in the "Shapes" folder in the plugin directory and
                           -- add the Catagory or shape name in the dictionary)
                           local shapes_dict = {
                            [1] = {
                                name = "Geometric-2D",
                                shapes = {
                                    [1] = { name = "Arrowhead", shapeName = "arrowHead" },
                                    [2] = { name = "Scalene Triangle", shapeName = "scaleneTriangle" },
                                    [3] = { name = "Equilateral Triangle", shapeName = "equilateralTriangle" },
                                    [4] = { name = "Right Angle Triangle", shapeName = "rightAngleTriangle" },
                                },
                            },
                            [2] = {
                                name = "Geometric-3D",
                                shapes = {
                                    [1] = { name = "Cube", shapeName = "cube" },
                                    [2] = { name = "Cylinder", shapeName = "cylinder" },
                                    [3] = { name = "Sphere", shapeName = "sphere" },
                                    [4] = { name = "Hemisphere", shapeName = "hemisphere" },
                                    [5] = { name = "Cone", shapeName = "cone" },
                                    [6] = { name = "Dish", shapeName = "dish" },
                                },
                            },
                            [3] = {
                                name = "Axis System",
                                shapes = {
                                    [1] = { name = "1st Quadrant", shapeName = "1st_Quad" },
                                    [2] = { name = "1st & 2nd Quadrants", shapeName = "1st_and_2nd_Quad" },
                                    [3] = { name = "1st & 4th Quadrants", shapeName = "1st_and_4th_Quad" },
                                    [4] = { name = "Full Axis", shapeName = "full_Axis" },
                                    [5] = { name = "Full Axis with Grids", shapeName = "full_with_Grids" },
                                },
                            },
                            [4] = {
                                name = "Graphs",
                                shapes = {
                                    [1] = { name = "Sin x", shapeName = "sinx" },
                                    [2] = { name = "Cos x", shapeName = "cosx" },
                                    [3] = { name = "(sin x)^2", shapeName = "sinSqx" },
                                    [4] = { name = "(cos x)^2", shapeName = "cosSqx" },
                                    [5] = { name = "| sin x |", shapeName = "mod_sinx" },
                                    [6] = { name = "| cos x |", shapeName = "mod_cosx" },
                                },
                            },
                            [5] = {
                                name = "Physics-Diagrams",
                                shapes = {
                                    [1] = { name = "Spring", shapeName = "spring" },
                                    [2] = { name = "Immovable Support", shapeName = "2" },
                                    [3] = { name = "Circuit-1", shapeName = "3" },
                                    [4] = { name = "Circuit-2", shapeName = "4" },
                                    [5] = { name = "Circuit-3", shapeName = "5" },
                                    [6] = { name = "Circuit-4", shapeName = "6" },
                                },
                            },
                        }
                        


-- All functions for "Option Selection" and provide the name of the shape to the "insert_stroke" function

      -- Showing Main dialog for selecting shape categories (gives the primary options for the Shape-Catagory)
              function showMainShapeDialog()
                local options = {}
                for i, category in ipairs(shapes_dict) do
                    table.insert(options, category.name)
                end
                table.insert(options, "Cancel")  -- Add Cancel option
                app.openDialog("Select Shape Category", options, "mainShapeDialogCallback")
              end
            
            
      -- Callback for the main shape dialog
              function mainShapeDialogCallback(result)
                if result == #shapes_dict + 1 then
                    -- Closes the main dialog
                    return
                elseif result >= 1 and result <= #shapes_dict then
                    showShapeDialog(result)
                end
              end

            
      -- Showing secondary dialog for selecting shape (gives the secondary options for selecting shapes)
              function showShapeDialog(categoryIndex)
                local category = shapes_dict[categoryIndex]
              
                local options = {}
              
                for i, shape in ipairs(category.shapes) do
                    table.insert(options, shape.name)
                end
              
                table.insert(options, "Back")  -- Add Back option
              
                -- Open the dialog with shape names
                app.openDialog("Select Shape", options, "shapeDialogCallback")
              end

      -- Callback for the secondary shape dialog (This part should provide  "shapeName" of the selected shape-option to "insert_stroke(shape_name)", But this part is beyond my ability )
              function shapeDialogCallback(result)
                    local shapeName = "sinSqx" -- As I am unable to extract the shapeName from the Shape-Dictionary I just assume it for testing
                    if
 --                  result == #numShape +1 then
 --                     showMainShapeDialog() -- When "Back" option is selected the secondary dialog closes and main dialog reopens
 --                   elseif 
                    result >= 1 and result <= #shapes_dict then
                        insert_stroke(shapeName)
                    end
              end


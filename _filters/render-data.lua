--[[
  render-data.lua – Quarto Lua filter that renders YAML data files.
  
  Usage in .qmd files:
    ::: {.render-publications}
    :::
    
    ::: {.render-projects}
    :::
    
    ::: {.render-skills}
    :::
    
    ::: {.render-timeline}
    :::
]]

local function read_yaml(path)
  local f = io.open(path, "r")
  if not f then
    io.stderr:write("render-data.lua: cannot open " .. path .. "\n")
    return nil
  end
  local content = f:read("*a")
  f:close()

  local python_exec = "python3"
  if package.config:sub(1,1) == "\\" then
    python_exec = "python"
  end

  local ok, result = pcall(function()
    return quarto.json.decode(
      pandoc.pipe(python_exec, {"-c",
        "import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin.read()), sys.stdout)"
      }, content)
    )
  end)

  if not ok then
    io.stderr:write("render-data.lua: YAML parse error for " .. path .. "\n")
    return nil
  end
  return result
end

local function render_publications(div)
  local pubs = read_yaml("_data/publications.yml")
  if not pubs then return div end

  local rows = {}
  table.insert(rows, '<table class="pub-table">')
  table.insert(rows, '<thead><tr><th>Year</th><th>Title</th><th>Journal</th></tr></thead>')
  table.insert(rows, '<tbody>')

  for _, pub in ipairs(pubs) do
    local title = pub.title or ""
    local url = pub.url or ""
    local journal = pub.journal or ""
    local year = tostring(pub.year or "")

    local title_cell
    if url ~= "" then
      title_cell = '<a href="' .. url .. '" target="_blank">' .. title .. '</a>'
    else
      title_cell = title
    end

    table.insert(rows, '<tr>')
    table.insert(rows, '  <td class="pub-year">' .. year .. '</td>')
    table.insert(rows, '  <td>' .. title_cell .. '</td>')
    table.insert(rows, '  <td>' .. journal .. '</td>')
    table.insert(rows, '</tr>')
  end

  table.insert(rows, '</tbody></table>')
  return pandoc.RawBlock("html", table.concat(rows, "\n"))
end

local function render_projects(div)
  local projects = read_yaml("_data/projects.yml")
  if not projects then return div end

  local areas = {}
  local area_order = {}
  for _, p in ipairs(projects) do
    local area = p.area or "Other"
    if not areas[area] then
      areas[area] = {}
      table.insert(area_order, area)
    end
    table.insert(areas[area], p)
  end

  local blocks = {}
  
  -- 1. Render Portfolio TOC
  table.insert(blocks, '<div class="portfolio-toc">')
  table.insert(blocks, '  <div class="toc-label">Filter by Area:</div>')
  for _, area in ipairs(area_order) do
    local area_id = area:lower():gsub("[^a-z0-9]", "-")
    table.insert(blocks, '  <a href="#' .. area_id .. '" class="toc-link">' .. area .. '</a>')
  end
  table.insert(blocks, '</div>')

  -- 2. Render Project Sections
  for _, area in ipairs(area_order) do
    local area_id = area:lower():gsub("[^a-z0-9]", "-")
    table.insert(blocks, '<h2 id="' .. area_id .. '" class="project-section-title">' .. area .. '</h2>')
    
    for _, proj in ipairs(areas[area]) do
      local title = proj.title or ""
      local objectives = proj.objectives or ""
      local data = proj.data or ""
      local methodology = proj.methodology or ""

      table.insert(blocks, '<details class="project-card">')
      table.insert(blocks, '  <summary class="project-header">')
      table.insert(blocks, '    <h3 class="project-title">' .. title .. '</h3>')
      table.insert(blocks, '    <div class="project-cta"><i class="bi bi-chevron-down"></i></div>')
      table.insert(blocks, '  </summary>')
      table.insert(blocks, '  <div class="project-content">')
      
      if objectives ~= "" then
        table.insert(blocks, '    <div class="project-section">')
        table.insert(blocks, '      <div class="section-label"><i class="bi bi-bullseye"></i> Objectives</div>')
        table.insert(blocks, '      <div class="section-text">' .. objectives .. '</div>')
        table.insert(blocks, '    </div>')
      end
      
      if data ~= "" then
        table.insert(blocks, '    <div class="project-section">')
        table.insert(blocks, '      <div class="section-label"><i class="bi bi-database"></i> Data & Sources</div>')
        table.insert(blocks, '      <div class="section-text">' .. data .. '</div>')
        table.insert(blocks, '    </div>')
      end
      
      if methodology ~= "" then
        table.insert(blocks, '    <div class="project-section">')
        table.insert(blocks, '      <div class="section-label"><i class="bi bi-gear-wide-connected"></i> Methodology</div>')
        table.insert(blocks, '      <div class="section-text">' .. methodology .. '</div>')
        table.insert(blocks, '    </div>')
      end
      
      table.insert(blocks, '  </div>')
      table.insert(blocks, '</details>')
    end
  end

  return pandoc.RawBlock("html", table.concat(blocks, "\n"))
end

local function render_skills(div)
  local data = read_yaml("_data/cv.yml")
  if not data or not data.skills then return div end

  local html = {}
  table.insert(html, '<div class="skill-bar-container"><div class="skill-columns">')

  local sections = {
    {key = "domain",     title = "Domain Knowledge"},
    {key = "analytical", title = "Analytical Skills"},
    {key = "technical",  title = "Technical Skills"},
  }

  for _, sec in ipairs(sections) do
    local items = data.skills[sec.key]
    if items then
      table.insert(html, '<div class="skill-col">')
      table.insert(html, '<h3>' .. sec.title .. '</h3>')
      for _, item in ipairs(items) do
        local name = item.name or ""
        local level = tostring(item.level or 0)
        table.insert(html, '<div class="skill-item">')
        table.insert(html, '  <div class="skill-name">' .. name .. '</div>')
        table.insert(html, '  <div class="skill-bar"><div class="skill-fill" style="width:' .. level .. '%">' .. level .. '%</div></div>')
        table.insert(html, '</div>')
      end
      table.insert(html, '</div>')
    end
  end

  table.insert(html, '</div></div>')
  return pandoc.RawBlock("html", table.concat(html, "\n"))
end

local function render_timeline(div)
  local data = read_yaml("_data/cv.yml")
  if not data or not data.timeline then return div end

  local groups = {
    Education = {},
    Experience = {},
    Teaching = {}
  }

  for _, item in ipairs(data.timeline) do
    local g = item.group or "Other"
    if not groups[g] then groups[g] = {} end
    table.insert(groups[g], item)
  end

  for g, list in pairs(groups) do
    table.sort(list, function(a, b)
      return (a.start or "") > (b.start or "")
    end)
  end

  local html = {}
  table.insert(html, '<div class="skill-bar-container"><div class="skill-columns">')

  local group_order = {"Education", "Experience", "Teaching"}
  
  for _, g in ipairs(group_order) do
    local list = groups[g]
    if list and #list > 0 then
      table.insert(html, '<div class="timeline-col">')
      table.insert(html, '<h3 class="timeline-col-title">' .. g .. '</h3>')
      table.insert(html, '<div class="timeline-section" style="margin-top: 1rem;">')
      
      for _, item in ipairs(list) do
        local year = (item.start or ""):sub(1, 4)
        local content = item.content or ""
        
        table.insert(html, '<div class="timeline-item">')
        table.insert(html, '  <div class="tl-year">' .. year .. '</div>')
        table.insert(html, '  <div class="tl-title">' .. content .. '</div>')
        table.insert(html, '</div>')
      end
      
      table.insert(html, '</div></div>')
    end
  end

  table.insert(html, '</div></div>')
  return pandoc.RawBlock("html", table.concat(html, "\n"))
end

function Div(div)
  if div.classes:includes("render-publications") then
    return render_publications(div)
  elseif div.classes:includes("render-projects") then
    return render_projects(div)
  elseif div.classes:includes("render-skills") then
    return render_skills(div)
  elseif div.classes:includes("render-timeline") then
    return render_timeline(div)
  end
  return div
end

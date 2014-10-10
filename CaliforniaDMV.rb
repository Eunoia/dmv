module CaliforniaDMV
  def tasks
    %i| taskDL taskDLO taskDLN taskRWT taskVR |
  end
  def offices
    YAML.load_file("offices.yml")
  end
  def default_options
    {
      numberItems:"1",
      firstName:"Yolo",
      lastName:"SWAG",
      telArea:"415",
      telPrefix:"867",
      telSuffix:"5309",
      resetCheckFields:"true"
    }
  end
  def url
    "https://www.dmv.ca.gov/wasapp/foa/findOfficeVisit.do"
  end
end

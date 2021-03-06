require 'restrack'

module TestApp; end
class TestApp::WebService < RESTRack::WebService; end

RESTRack::CONFIG = RESTRack::load_config(File.join(File.dirname(__FILE__), 'config/constants.yaml'))
RESTRack::CONFIG[:ROOT] = File.dirname(__FILE__)

# Dynamically load all controllers
Find.find(  File.join(File.dirname(__FILE__), 'controllers') ) do |file|
  next if File.extname(file) != '.rb'
  require file
end

if File.directory?( File.join(File.dirname(__FILE__), 'models') )
  # Dynamically load all models
  Find.find(  File.join(File.dirname(__FILE__), 'models') ) do |file|
    next if File.extname(file) != '.rb'
    require file
  end
end

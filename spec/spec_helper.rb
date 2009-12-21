$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require 'spec'
require 'craps'

def result(die_1, die_2)
  {
    :die_1 => die_1,
    :die_2 => die_2,
    :total => die_1 + die_2
  }
end

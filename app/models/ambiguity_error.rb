class AmbiguousError < StandardError
  def initialize(data)
    @data = data
  end
end
  

module Ambiguity
  def self.handle(list, error_type)
    size = list.size
    if size == 1 then return list.first end
    if size > 1 then raise AmbiguousError.new(error_type: :topic, data: list) end
    yield
  end
end


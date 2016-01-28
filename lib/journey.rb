class Journey
  def initialize
    @list = []
  end

  def import(completed_hash)
    list << completed_hash
  end

  def return_list
    list
  end

  attr_reader :list

end
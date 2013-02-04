class Rate < Neo4j::Rails::Relationship
  property :grade, :type => Fixnum
  property :comment, :type => String

  attr_accessor :grade, :comment
  attr_accessible :grade, :comment

# this is necessary to be able to make forms with the form_for helper
  def to_key
    persisted? ? [id] : nil
  end

  # this is for the routing helpers
  def to_param
    persisted? ? neo_id.to_s : nil
  end

end

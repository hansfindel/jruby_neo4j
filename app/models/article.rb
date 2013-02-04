class Article < Neo4j::Rails::Model
  property :title, :type => String, :index => :exact, :unique => true
  property :content, :type => String
  property :date, :type => String

  def to_param
    title.parameterize
  end
  before_create :set_date

  validates :title, :content, :presence => true

  has_n(:users).to(User, :rates).relationship(Rate)
  has_n(:users).to(User, :writes).relationship(Write)

  def set_date
  	self.date = Time.now.strftime("%H:%M %d/%m/%y").to_s
  end


end

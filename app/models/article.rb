class Article < ActiveRecord::Base
	#La tabla => Articles
	#Campos=> article.title()=>'el titulo der articulo'
	#Escribir Metodos
	belongs_to :user 
	has_many :comments
	has_many :has_categories
	has_many :categories, through: :has_categories
	
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true , length: {minimum: 20}
	before_save :set_visits_count
	after_create :save_categories

	has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600" }
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
 	
	#Custom setter / Setter personalizado
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		  self.update(visits_count: self.visits_count + 1)
	end

	private
	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id,article_id: self.id)
		end	
	end
	def set_visits_count
		self.visits_count ||= 0
	end
end

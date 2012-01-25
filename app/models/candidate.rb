class Candidate < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :score
	
	validates_numericality_of :score

	validates_uniqueness_of :name
end

class Racer

	#We used self because there is one mongo_client to all racers
	attr_accessor :id ,:number ,:first_name ,:last_name ,:gender ,:group ,:secs
	def self.mongo_client
		Mongoid::Clients.default
	end

	def self.collection
		self.mongo_client[:racers]
	end

	def  self.all (prototype={:number => {:$gt => -1}} ,sort={number: 1} ,skip=0 ,limit=1)
		self.collection.find(prototype).sort(sort).skip(skip).limit(limit)
	end

	def initialize(params)
		@number=params[:number]
		@first_name=params[:first_name]
		@last_name=params[:last_name]
		@gender=params[:gender]
		@group=params[:group]
		@secs=params[:secs]
		if params[:id].nil?
			@id=params[:_id].to_s
		elsif params[:_id].nil?
			@id=params[:id]
		end	 
	end

	def self.find id
		result=self.collection.find(:id => id)
		if result.nil?
			return Racer.new(result)
		end
	end

end
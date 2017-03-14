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

	#def new (params)
	#	self.initialize(params)
	#end

	def initialize(params)
		if params[:id].nil?
			@id=params[:_id].to_s
		elsif params[:_id].nil?
			@id=params[:id]
		end	 
		@number=params[:number]
		@first_name=params[:first_name]
		@last_name=params[:last_name]
		@gender=params[:gender]
		@group=params[:group]
		@secs=params[:secs]
	end

	def self.find id
		result=collection.find(_id: BSON.ObjectId(id)).first #BSON.ObjectId(id"as a string") for representation id as BSON::ObjectId
		if result.nil?
			return nil
		else
			return Racer.new(result)
		end
	end

end
class CandidateController < ApplicationController
	before_filter :find_candidates, :only => [:index]
	before_filter :find_candidate, :only => [:update]

  def new
  end

  def create
  	@cand = Candidate.new(params[:candidate])

  	respond_to do |format|
  		if @cand.save
        format.json { render json: @cand, status: :created, location: @cand }
      else
        format.json { render json: @cand.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  	respond_to do |format|
  		format.json { render json: @candidates }
  	end
  end

  def update
  	respond_to do |format|
      if @cand.update_attributes(params[:candidate])
        format.json { head :ok }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  protected

  def find_candidate
  	@cand = Candidate.find(params[:id])
  end

  def find_candidates
  	@candidates = Candidate.all
  end

end

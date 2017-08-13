class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    # TODO: If combination voter poll item is already present -> error (user should edit)

    poll_id = vote_params[:poll_id].to_i
    item_id = vote_params[:item_id].to_i

    proposal = Proposal.find_by(poll_id: poll_id, item_id: item_id)
  
    if proposal.nil?
      puts "Cannot find proposal with poll_id #{poll_id} and item_id #{item_id}. Creating one."

      proposal = Proposal.new({
        poll_id: poll_id,
        item_id: item_id
      })
      proposal.save
    end

    @vote = Vote.new({
      voter_id: vote_params[:voter_id],
      proposal_id: proposal.id,
      preference: vote_params[:preference]
    })

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    # TODO: Copy create code and adjust?

    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])

      proposal = Proposal.find(@vote.proposal_id)

      @poll_id = proposal.poll_id
      @item_id = proposal.item_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:poll_id, :item_id, :voter_id, :preference)
    end
end

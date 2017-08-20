class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :results, :votes, :votes!]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # GET /polls/1/results
  def results
    proposals = Proposal.where(poll_id: @poll.id)
    @items = Item.where(id: proposals.pluck(:item_id))
    @votes = get_votes_for_poll(@poll)
    @voters = Voter.where(id: @votes.pluck(:voter_id))
  end

  # GET /polls/1/vote
  def votes
    @items = Item.all

    # TODO: Fill model with data
  end

  # POST /polls/1/votes
  def votes!
    if params[:voter_id].nil? or params[:voter_id] == ''
      respond_to do |format|
        format.html { redirect_to votes_polls_path, notice: 'Wähler auswählen!' }
        format.json { render status: :unprocessable_entity }
      end
    else
      voter_id = params[:voter_id].to_i

      params.each do |key, preference_value|
        if /preference_(\d+)/.match(key)
          item_id = $1.to_i
          preference = preference_value.to_sym

          proposal = Proposal.find_by(poll_id: @poll.id, item_id: item_id)

          if preference != :none
            if proposal.nil?
              puts "Cannot find proposal with poll_id #{@poll.id} and item_id #{item_id}. Creating one."

              proposal = Proposal.new({
                poll_id: @poll.id,
                item_id: item_id
              })
              proposal.save!
            end

            vote = Vote.find_by(voter_id: voter_id, proposal_id: proposal.id)

            if vote.nil?
              vote = Vote.new({
                voter_id: voter_id,
                proposal_id: proposal.id,
                preference: preference
              })

              vote.save!
            else
              vote.update!({
                voter_id: voter_id,
                proposal_id: proposal.id,
                preference: preference
              })
            end
          else
            # No preference -> delete vote if it exists
            if !proposal.nil?
              vote = Vote.find_by(voter_id: voter_id, proposal_id: proposal.id)

              if !vote.nil?
                vote.destroy
              end
            end
          end
        end
      end

      respond_to do |format|
        format.html { redirect_to polls_url, notice: 'Erfolgreich abgestimmt.' }
        format.json { head :no_content }
      end
    end
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:name, :description, :status, :started_at, :concluded_at)
    end

    # TODO: Should prob. be inside a service / helper of some kind?
    def get_votes_for_poll(poll)
      proposal_ids = Proposal.where(poll_id: poll.id).pluck(:id)

      Vote.where(proposal_id: proposal_ids)
    end
end

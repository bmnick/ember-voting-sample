# View for displaying an individual candidate
VoteList.CandidateView = Ember.View.extend
  # Candidate model this view is representing
  person: null
  
  # View helper to pass calls down to the model
  upvote: ->
    this.person.upvote()
  
  # View helper to pass calls down to the model
  downvote: ->
    this.person.downvote()

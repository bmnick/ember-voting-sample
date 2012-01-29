# View for creating a new candidate
VoteList.CreateCandidateView = Ember.TextField.extend
  # Automate having new items inserted into the 
  # list of candidates when enter is pressed
  insertNewline: ->
    val = this.get('value');
    
    if val
      VoteList.CandidateController.createCandidate val
      this.set 'value', ''

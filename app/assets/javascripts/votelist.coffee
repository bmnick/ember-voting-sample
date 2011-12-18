VoteList = Em.Application.create()


VoteList.Candidate = Em.Object.extend
  name: 'somebody'
  score: 0
  
  # Increment the score by one
  upvote: ->
    this.set 'score', this.get('score') + 1
  
  # Decrement the score by one
  downvote: ->
    this.set 'score', this.get('score') - 1
  
  
VoteList.CandidateController = Em.ArrayController.create
  content: []

  # Computed property to keep content sorted
  sortedContent:(() ->
    content = this.get('content')
    
    if content
      result = Em.copy content
      
      result.sort ( a, b ) ->
        b.get('score') - a.get('score')
    else
      []
  ).property('@each.score').cacheable()
  
  # Creation method for adding a new canddiate
  createCandidate: (name) ->
    cand = VoteList.Candidate.create name: name
    this.pushObject(cand)


VoteList.CreateCandidateView = Em.TextField.extend
  # Automate having new items inserted into the 
  # list of candidates when enter is pressed
  insertNewline: ->
    val = this.get('value');
    
    if val
      VoteList.CandidateController.createCandidate val
      this.set 'value', ''


VoteList.CandidateView = Em.View.extend
  person: null
  
  # View helper to pass calls down to the model
  upvote: ->
    this.person.upvote()
  
  # View helper to pass calls down to the model
  downvote: ->
    this.person.downvote()


# Send VoteList out to the rest of the system
root = exports ? this
root.VoteList = VoteList
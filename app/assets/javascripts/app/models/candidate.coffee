# Model object indicating one potential vote recipient. Defaulted to 
# the RESTful resource located at '<server>/candidate'
VoteList.Candidate = Ember.Resource.extend
  # RESTful resource configuration
  url: 'candidate'
  name: 'candidate'
  properties: ['displayName', 'score']

  # The name to display for the candidate
  displayName: 'somebody'

  # The "score" for the candidate - sum of votes for and against
  score: 0
  
  # Increment the score by one
  upvote: ->
    this.set 'score', this.get('score') + 1
    this.save()
  
  # Decrement the score by one
  downvote: ->
    this.set 'score', this.get('score') - 1
    this.save()
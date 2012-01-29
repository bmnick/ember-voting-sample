# Controller for candidate models. Hooked up through ember-rest to connect to the 
# server via a RESTful API.
VoteList.CandidateController = Ember.ResourceController.create
  type: VoteList.Candidate
  url: 'candidate'

  # Computed property to keep content sorted
  sortedContent:(() ->
    content = this.get('content')
    
    if content
      result = Ember.copy content
      
      result.sort ( a, b ) ->
        b.get('score') - a.get('score')
    else
      []
  ).property('@each.score').cacheable()
  
  # Creation method for adding a new canddiate
  createCandidate: (displayName, shouldSave = true, score = 0, id) ->
    #TODO: clean?
    cand = VoteList.Candidate.create displayName: displayName, score: score, id: id

    this.pushObject(cand)

    if (shouldSave)
      cand.save()
# Ember.js Application
VoteList = Ember.Application.create()


# Model object indicating one potential vote recipient
VoteList.Candidate = Ember.Resource.extend
  url: 'candidate'
  name: 'candidate'
  properties: ['displayName', 'score']

  displayName: 'somebody'
  score: 0
  
  # Increment the score by one
  upvote: ->
    this.set 'score', this.get('score') + 1
    this.save()
  
  # Decrement the score by one
  downvote: ->
    this.set 'score', this.get('score') - 1
    this.save()


# Controller for candidate models
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
    console.log displayName
    cand = VoteList.Candidate.create displayName: displayName, score: score, id: id

    this.pushObject(cand)

    if (shouldSave)
      cand.save()


# View for creating a new candidate
VoteList.CreateCandidateView = Ember.TextField.extend
  # Automate having new items inserted into the 
  # list of candidates when enter is pressed
  insertNewline: ->
    val = this.get('value');
    
    if val
      VoteList.CandidateController.createCandidate val
      this.set 'value', ''


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


# Basic setup on first page load
jQuery ->
  # Setup common AJAX settings for most requests
  $.ajaxSetup
    type: 'POST'
    headers: 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    accept: 'application/json'

  VoteList.CandidateController.findAll()


# Send VoteList out to the rest of the system
root = exports ? this
root.VoteList = VoteList
# Ember.js Application
VoteList = Ember.Application.create()


# Model object indicating one potential vote recipient
VoteList.Candidate = Ember.Object.extend
  name: 'somebody'
  score: 0
  id: -1
  
  # Increment the score by one
  upvote: ->
    this.set 'score', this.get('score') + 1
    this.update()
  
  # Decrement the score by one
  downvote: ->
    this.set 'score', this.get('score') - 1
    this.update()

  # Add this model to the server
  create: ->
    $.ajax 'candidate',
      data: {candidate: {name: this.get('name'), score: this.get('score')}}
      success: (data) -> console.log(data)
  
  # Save changes from the model to the server
  update: ->
    $.ajax 'candidate/' + this.id,
      type: 'PUT'
      data: {candidate: {name: this.get('name'), score: this.get('score')}}
      success: (data) -> console.log(data)


# Controller for candidate models
VoteList.CandidateController = Ember.ArrayController.create
  content: []

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
  createCandidate: (name, shouldSave = true, score = 0, id) ->
    cand = VoteList.Candidate.create name: name, score: score, id: id
    this.pushObject(cand)
    if (shouldSave)
      cand.create()


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
  console.log('ready')

  # Setup common AJAX settings for most requests
  $.ajaxSetup
    type: 'POST'
    headers: 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    accept: 'application/json'
  
  # Load the candidates to use initially
  $.ajax
    type: 'GET'
    url: 'candidate'
    success: (data) ->
      jQuery.each data, (i, elem) ->
        VoteList.CandidateController.createCandidate(elem.name, false, elem.score, elem.id)


# Send VoteList out to the rest of the system
root = exports ? this
root.VoteList = VoteList
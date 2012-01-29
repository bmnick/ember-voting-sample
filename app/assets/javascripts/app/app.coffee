# Ember.js Application
VoteList = Ember.Application.create()

# Basic page load configuration
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

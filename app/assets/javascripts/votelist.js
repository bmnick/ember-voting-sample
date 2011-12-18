VoteList = Em.Application.create();

VoteList.Candidate = Em.Object.extend({
  name: 'somebody',
  score: 0,
  
  /* Increment the score by one
   */
  upvote: function() {
    this.set('score', this.get('score') + 1);
  },
  
  /* Decrement the score by one
   */
  downvote: function() {
    this.set('score', this.get('score') - 1);
  }
});
  
VoteList.CandidateController = Em.ArrayController.create({
  content: [],

  /* Computed property to keep content sorted
   */
  sortedContent: function() {
    var content = this.get('content');
    
    if (content) {
      var result = Em.copy(content);
      
      return result.sort( function( a, b ) {
        return b.get('score') - a.get('score');
      });
    } else {
      return [];
    }
  }.property('@each.score').cacheable(),
  
  /* Creation method for adding a new canddiate
   */
  createCandidate: function(name) {
    var cand = VoteList.Candidate.create({name: name});
    this.pushObject(cand);
  }
});

VoteList.CreateCandidateView = Em.TextField.extend({
  /* Automate having new items inserted into the 
   * list of candidates when enter is pressed
   */
  insertNewline: function() {
    val = this.get('value');
    
    if (val) {
      VoteList.CandidateController.createCandidate(val);
      this.set('value', '');
    }
  }
});

VoteList.CandidateView = Em.View.extend({
  person: null,
  
  /* View helper to pass calls down to the model
   */
  upvote: function() { 
    this.person.upvote()
  },
  
  /* View helper to pass calls down to the model
   */
  downvote: function() { 
    this.person.downvote()
  }
});

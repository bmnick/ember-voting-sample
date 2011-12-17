// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var MAPList = Em.Application.create();

MAPList.AP = Em.Object.extend({
  name: 'somebody',
  score: 0,
  
  upvote: function() {
    this.score += 1;
    console.log("called");
  },
  
  downvote: function() {
    this.score -= 1;
    console.log("down");
  }
});

MAPList.APController = Em.ArrayProxy.create({
  content: [],
  
  createAp: function(name) {
    var ap = MAPList.AP.create({ name: name });
    this.pushObject(ap);
  }

});

MAPList.CreateAPView = Em.TextField.extend({
  insertNewline: function() {
    var val = this.get('value');
    
    if (val) {
      MAPList.APController.createAp(val);
      this.set('value', '');
    }
  }
});

MAPList.APView = Em.View.extend({
  person: null,
  
  upvote: function() {
    console.log("up");
    this.person.set('score', this.person.get('score') + 1);
  },
  
  downvote: function() {
    console.log("down");
    this.person.set('score', this.person.get('score') - 1);
  }
});

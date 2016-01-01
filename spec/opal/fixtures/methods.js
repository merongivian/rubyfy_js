Person = function() {};

Person.prototype.greet = function(name) {
  return 'Hey ' + name + ', nice to meet you'
}

Person.prototype.sayHello = function() {
  return 'hello';
};

Person.prototype.sayBye = function() {
  return 'bye';
};

//private methods

Person.prototype._deepThoughts = function() {
  return 'We are not alone in the universe';
};

Person.prototype._any = function() {
  return 'any';
};

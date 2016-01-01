Jungle = function() {
  this.littlePuma  = new Puma(1);
  this.bigLion     = new Lion(7);
  this.littleZebra = new Zebra(3);
  this.population   = 3;
};

//-------------------------------------------

Puma = function(age) {
  this.age = age;
};

Puma.prototype.sayRoar = function() {
  return 'Roar!!!, im hungry';
};

//-------------------------------------------

Lion = function(age) {
  this.age = age;
};

Lion.prototype.sayRoar = function() {
  return 'Roar!!!, im the king of the jungle';
};

//-------------------------------------------

Zebra = function(age) {
  this.age = age;
};

Zebra.prototype.sayRun = function() {
 return 'look a lion, run';
};

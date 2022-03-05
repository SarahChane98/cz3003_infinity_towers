
class Checkpoint {
  final String name;
  final bool unlocked;

  Checkpoint(this.name, this.unlocked);
}


class Tower {
  final String name;
  final List<Checkpoint> checkpoints;

  Tower(this.name, this.checkpoints);
}


Tower mockTower1 = new Tower("Python", [
  Checkpoint("Introduction", true),
  Checkpoint("Basic Syntax", true),
  Checkpoint("Advanced Syntax", false),
  Checkpoint("Control logic", false),
]);


Tower mockTower2 = new Tower("Algorithms", [
  Checkpoint("Introduction", true),
  Checkpoint("Search", true),
  Checkpoint("Sort", false),
  Checkpoint("Graphs", false),
]);
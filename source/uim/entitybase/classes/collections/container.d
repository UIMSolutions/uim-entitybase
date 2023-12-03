module uim.entitybase.classes.collections.container;

import uim.entitybase;

version(testUimEntitybase) { 
  unittest {
    debug writeln("\n", __MODULE__~":"~__PRETTY_FUNCTION__); 
  }
}

@safe:
class DEntityCollectionContainer : DNamedContainer!IEntityCollection {
} 
auto EntityCollectionContainer() { return new DEntityCollectionContainer(); }

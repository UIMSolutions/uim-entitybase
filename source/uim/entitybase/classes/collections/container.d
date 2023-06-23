module uim.entitybase.classes.collections.container;

@safe:
import uim.entitybase;

class DEntityCollectionContainer : DNamedContainer!IEntityCollection {
} 
auto EntityCollectionContainer() { return new DEntityCollectionContainer(); }

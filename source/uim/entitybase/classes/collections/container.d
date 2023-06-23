module uim.entitybase.classes.collections.container;

@safe:
import uim.entitybase;

class DEntityCollectionContainer : DNamedContainer!IEntityContainer {
} 
auto EntityCollectionContainer() { return new DEntityCollectionContainer(); }

module uim.entitybase.classes.bases.container;

@safe:
import uim.entitybase;

class DEntityBaseContainer : DNamedContainer!IEntityContainer {
} 
auto EntityBaseContainer() { return new DEntityBaseContainer(); }

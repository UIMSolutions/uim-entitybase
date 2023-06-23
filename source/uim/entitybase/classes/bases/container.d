module uim.entitybase.classes.bases.container;

@safe:
import uim.entitybase;

class DEntityBaseContainer : DNamedContainer!IEntityBase {
} 
auto EntityBaseContainer() { return new DEntityBaseContainer(); }

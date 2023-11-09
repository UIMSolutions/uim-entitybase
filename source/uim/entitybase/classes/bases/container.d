module uim.entitybase.classes.bases.container;

import uim.entitybase;

@safe:
class DEntityBaseContainer : DNamedContainer!IEntityBase {
} 
auto EntityBaseContainer() { return new DEntityBaseContainer(); }

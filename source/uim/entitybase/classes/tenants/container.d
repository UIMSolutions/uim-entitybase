module uim.entitybase.classes.tenants.container;

@safe:
import uim.entitybase;

class DEntityTenantContainer : DNamedContainer!IEntityContainer {
} 
auto EntityTenantContainer() { return new DEntityTenantContainer(); }

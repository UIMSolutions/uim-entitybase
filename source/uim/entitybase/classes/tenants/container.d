module uim.entitybase.classes.tenants.container;

@safe:
import uim.entitybase;

class DEntityTenantContainer : DNamedContainer!IEntityTenant {
} 
auto EntityTenantContainer() { return new DEntityTenantContainer(); }

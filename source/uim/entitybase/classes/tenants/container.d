module uim.entitybase.classes.tenants.container;

import uim.entitybase;

version(testUimEntitybase) { 
  unittest {
    debug writeln("\n", __MODULE__~":"~__PRETTY_FUNCTION__); 
  }
}

@safe:
class DEntityTenantContainer : DNamedContainer!IEntityTenant {
} 
auto EntityTenantContainer() { return new DEntityTenantContainer(); }

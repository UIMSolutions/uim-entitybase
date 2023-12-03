module uim.entitybase.helpers.tenantmanager;

import uim.entitybase;

version(testUimEntitybase) { 
  unittest {
    debug writeln("\n", __MODULE__~":"~__PRETTY_FUNCTION__); 
  }
}

@safe:
bool isNull(IEntityTenantManager aManager) {
  return (aManager is null);
}
module uim.entitybase.helpers.collection;

import uim.entitybase;

version(testUimEntitybase) { 
  unittest {
    debug writeln("\n", __MODULE__~":"~__PRETTY_FUNCTION__); 
  }
}

@safe:

auto collection(IEntityTenantManager aTenantManager, string aTenantName, string aCollectionName) {
  if (aTenantManager.isNull) { return null; }

  auto myTenant = aTenantManager.entityTenant(aTenantName);
  if (!myTenant) return null;

  return myTenant.entityCollection(aCollectionName);
}
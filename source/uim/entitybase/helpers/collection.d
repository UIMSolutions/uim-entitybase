module uim.entitybase.helpers.collection;

import uim.entitybase;
@safe:

auto collection(IEntityTenantManager aTenantManager, string aTenantName, string aCollectionName) {
  if (!aTenantManager) return null;

  auto myTenant = aTenantManager.entityTenant(aTenantName);
  if (!myTenant) return null;

  return myTenant.entityCollection(aCollectionName);
}
module uim.entitybase.helpers.collection;

auto collection(IEntityBase entityBase, string tenantName, string collectionName) {
  if (!entityBase) return null;

  auto myTenant = entityBase.tenant(tenantName);
  if (!myTenant) return null;

  auto myCollection = myTenant.collection(collectionName);
  return myCollection;
}
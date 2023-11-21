module uim.entitybase.helpers.base;

import uim.entitybase;

@safe:
bool isNull(IEntityTenantManager aManager) {
  return (aManager is null);
}
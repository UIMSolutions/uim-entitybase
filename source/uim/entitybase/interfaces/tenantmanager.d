module uim.entitybase.interfaces.tenantmanager;

@safe:
import uim.entitybase;

interface IEntityTenantManager {
  void entityTenantContainer(DEntityTenantContainer aContainer);
  DEntityTenantContainer entityTenantContainer();

  void entityTenants(IEntityTenant[string] someTenants);
  void entityTenants(IEntityTenant[] someTenants);
  IEntityTenant[] entityTenants();
  string[] tenantNames();

  // set & get entitytenant
  IEntityTenant entityTenant(string aName);
  void entityTenant(string aName, IEntityTenant aEntityTenant);

  // Check existing entitytenant
  bool hasEntityTenant(IEntityTenant aTenant);
  bool hasEntityTenant(string aName);

  // Add new entitytenant without overwriting
  void addEntityTenant(IEntityTenant aTenant);
  void addEntityTenant(string aName, IEntityTenant aTenant);

  // Update existing entitytenant
  void updateEntityTenant(IEntityTenant aTenant);
  void updateEntityTenant(string aName, IEntityTenant aTenant);

  // Remove existing entitytenant
  void removeEntityTenant(IEntityTenant aTenant);
  void removeEntityTenant(string aName);

  // operator overloading
  IEntityTenant opIndex(string aName);
  void opIndexAssign(IEntityTenant aTenant, string aName);
}
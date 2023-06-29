module uim.entitybase.interfaces.tenantmanager;

@safe:
import uim.entitybase;

interface IEntityTenantManager {
  void tenantContainer(DEntityTenantContainer aContainer);
  DEntityTenantContainer tenantContainer();

  void tenants(IEntityTenant[string] someTenants);
  void tenants(IEntityTenant[] someTenants);
  IEntityTenant[] tenants();
  string[] tenantNames();

  // set & get entitytenant
  IEntityTenant tenant(string aName);
  void tenant(IEntityTenant aEntityTenant);
  void tenant(string aName, IEntityTenant aEntityTenant);

  // Check existing entitytenant
  bool hasTenant(IEntityTenant aTenant);
  bool hasTenant(string aName);

  // Add new entitytenant without overwriting
  void addTenant(IEntityTenant aTenant);
  void addTenant(string aName, IEntityTenant aTenant);

  // Update existing entitytenant
  void updateTenant(IEntityTenant aTenant);
  void updateTenant(string aName, IEntityTenant aTenant);

  // Remove existing entitytenant
  void removeTenant(IEntityTenant aTenant);
  void removeTenant(string aName);

  // operator overloading
  IEntityTenant opIndex(string aName);
  void opIndexAssign(IEntityTenant aTenant, string aName);
}
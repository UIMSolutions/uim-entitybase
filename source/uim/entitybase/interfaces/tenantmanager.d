module uim.entitybase.interfaces.tenantmanager;

@safe:
import uim.entitybase;

interface IEntityTenantManager {
  DEntityTenantContainer entityTenantContainer();

  IEntityTenant[] entityTenants();
  string[] entityTenantNames();
  size_t countEntityTenants();

  // set & get entitytenant
  IEntityTenant entityTenant(string aName);

  // Check existing entitytenant
  bool hasEntityTenants(IEntityTenant[] someTenants...);
  bool hasEntityTenants(IEntityTenant[] someTenants);

  bool hasEntityTenants(string[] someNames...);
  bool hasEntityTenants(string[] someNames);

  bool hasEntityTenant(IEntityTenant aTenant);
  bool hasEntityTenant(string aName);

  // Add new entitytenant without overwriting
  bool addEntityTenants(IEntityTenant[] someTenants...);
  bool addEntityTenants(IEntityTenant[] someTenants);
  bool addEntityTenants(IEntityTenant[string] someTenants);

  bool addEntityTenant(IEntityTenant aTenant);
  bool addEntityTenant(string aName, IEntityTenant aTenant);

  // #region Update existing entitytenant
    bool updateEntityTenants(IEntityTenant[] aTenant...);
    bool updateEntityTenants(IEntityTenant[] aTenant);

    bool updateEntityTenant(IEntityTenant aTenant);
    bool updateEntityTenant(string aName, IEntityTenant aTenant);
  // #endregion Update existing entitytenant

  // #region Remove existing entitytenant
    bool removeEntityTenants(IEntityTenant[] aTenant...);
    bool removeEntityTenants(IEntityTenant[] aTenant);

    bool removeEntityTenants(string[] aName...);
    bool removeEntityTenants(string[] aName);

    bool removeEntityTenant(IEntityTenant aTenant);
    bool removeEntityTenant(string aName);
  // #endregion Remove existing entitytenant
}
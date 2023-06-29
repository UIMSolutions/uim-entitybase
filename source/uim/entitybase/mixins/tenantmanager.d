/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.tenantmanager;

import uim.entitybase;
@safe:

mixin template EntityTenantManagerTemplate() {

  // #region tenantContainer
    protected DEntityTenantContainer _tenantContainer;

    void tenantContainer(DEntityTenantContainer aContainer) {
      _tenantContainer = aContainer;
    }
    DEntityTenantContainer tenantContainer() { 
      return tenantContainer; 
    }
  // #endregion tenantContainer

  // #region tenants
    void tenants(IEntityTenant[string] someTenants) {
      someTenants.byKeyValue.each!(kv => tenant(kv.key, kv.value));
    }

    void tenants(IEntityTenant[] someTenants) {
      someTenants.each!(col => tenant(col));
    }

    IEntityTenant[] tenants() { 
      if (tenantContainer) return tenantContainer.values;
      return null; 
    }
    string[] tenantNames() {
      if (tenantContainer) return tenantContainer.keys;
      return null;
    }
  // #endregion tenants

  // #region tenant
    IEntityTenant tenant(string aName) {
      if (tenantContainer) return tenantContainer[aName];
      return null;
    }
    void tenant(IEntityTenant aTenant) {
      if (aTenant) tenant(aTenant.name, aTenant);
    }
    void tenant(string aName, IEntityTenant aTenant) {
      if (tenantContainer) tenantContainer[aName] = aTenant;
    }
  // #endregion tenant

  // #region hasTenant
    bool hasTenant(IEntityTenant aTenant) {
      return (aTenant? hasTenant(aTenant.name) : false);
    }
    bool hasTenant(string aName) {
      return (tenantContainer ? tenantContainer.contains(aName) : false);
    }
  // #endregion hasTenant

  // Count tenants
  size_t length() {
    return (tenantContainer ? tenantContainer.length : 0);
  }

  // Add tenant if not exitst
  void addTenant(IEntityTenant aTenant) {
    if (aTenant) addTenant(aTenant.name, aTenant);
  }
  void addTenant(string aName, IEntityTenant aTenant) {
    if (tenantContainer && aTenant && !hasTenant(aName)) 
      tenantContainer.add(aName, aTenant);
  }

  // Update existing tenant
  void updateTenant(IEntityTenant aTenant) {
     if (aTenant) updateTenant(aTenant.name, aTenant);
  }
  void updateTenant(string aName, IEntityTenant aTenant) {
    if (aTenant && hasTenant(aName)) tenantContainer.update(aName, aTenant);
  }

  // Remove existing tenant
  void removeTenant(IEntityTenant aTenant) {
    if (aTenant) removeTenant(aTenant.name);
  }
  void removeTenant(string aName) {
    if (tenantContainer && hasTenant(aName)) tenantContainer.remove(aName);
  }

  // Operator overloading
  IEntityTenant opIndex(string aName) {
    return tenant(aName);
  }
  void opIndexAssign(IEntityTenant aTenant, string aName) {
    addTenant(aName, aTenant);  
  }
}
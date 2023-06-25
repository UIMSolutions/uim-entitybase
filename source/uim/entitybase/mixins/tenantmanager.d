/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.tenantmanager;

import uim.entitybase;
@safe:

mixin template EntityTenantManagerTemplate() {

  // #region entityTenantContainer
    protected DEntityTenantContainer _entityTenantContainer;

    void entityTenantContainer(DEntityTenantContainer aContainer) {
      _entityTenantContainer = aContainer;
    }
    DEntityTenantContainer entityTenantContainer() { 
      return _entityTenantContainer; 
    }
  // #endregion entityTenantContainer

  // #region entityTenants
    void entityTenants(IEntityTenant[string] someTenants) {
      someTenants.byKeyValue.each!(kv => entityTenant(kv.key, kv.value));
    }

    void entityTenants(IEntityTenant[] someTenants) {
      someTenants.each!(col => entityTenant(col));
    }

    IEntityTenant[] entityTenants() { 
      if (_entityTenantContainer) return _entityTenantContainer.values;
      return null; 
    }
    string[] tenantNames() {
      if (_entityTenantContainer) return _entityTenantContainer.keys;
      return null;
    }
  // #endregion entityTenants

  // #region entityTenant
    IEntityTenant entityTenant(string aName) {
      if (_entityTenantContainer) return _entityTenantContainer[aName];
      return null;
    }
    void entityTenant(IEntityTenant aEntityTenant) {
      if (aEntityTenant) entityTenant(aEntityTenant.name, aEntityTenant);
    }
    void entityTenant(string aName, IEntityTenant aEntityTenant) {
      if (_entityTenantContainer) _entityTenantContainer[aName] = aEntityTenant;
    }
  // #endregion entityTenant

  // #region hasEntityTenant
    bool hasEntityTenant(IEntityTenant aEntityTenant) {
      if (aEntityTenant) return hasEntityTenant(aEntityTenant.name);
      return false;
    }
    bool hasEntityTenant(string aName) {
      if (_entityTenantContainer) return _entityTenantContainer.contains(aName);
      return false;
    }
  // #endregion hasEntityTenant

  // Add entityTenant if not exitst
  void addEntityTenant(IEntityTenant aEntityTenant) {
    if (aEntityTenant) addEntityTenant(aEntityTenant.name, aEntityTenant);
  }
  void addEntityTenant(string aName, IEntityTenant aEntityTenant) {
    if (_entityTenantContainer && aEntityTenant && !hasEntityTenant(aName)) 
      _entityTenantContainer.add(aName, aEntityTenant);
  }

  // Update existing entityTenant
  void updateEntityTenant(IEntityTenant aEntityTenant) {
     if (aEntityTenant) updateEntityTenant(aEntityTenant.name, aEntityTenant);
  }
  void updateEntityTenant(string aName, IEntityTenant aEntityTenant) {
    if (aEntityTenant && hasEntityTenant(aName)) _entityTenantContainer.update(aName, aEntityTenant);
  }

  // Remove existing entityTenant
  void removeEntityTenant(IEntityTenant aEntityTenant) {
    if (aEntityTenant) removeEntityTenant(aEntityTenant.name);
  }
  void removeEntityTenant(string aName) {
    if (_entityTenantContainer && hasEntityTenant(aName)) _entityTenantContainer.remove(aName);
  }

  // Operator overloading
  IEntityTenant opIndex(string aName) {
    return entityTenant(aName);
  }
  void opIndexAssign(IEntityTenant aEntityTenant, string aName) {
    addEntityTenant(aName, aEntityTenant);  
  }
}
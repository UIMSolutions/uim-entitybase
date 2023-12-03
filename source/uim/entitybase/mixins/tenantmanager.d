/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.tenantmanager;

import uim.entitybase;
@safe:

mixin template EntityTenantContainerTemplate() {
  // #region tenantContainer
    protected DEntityTenantContainer _entityTenantContainer;  
    DEntityTenantContainer entityTenantContainer() {
      if (entityTenantContainer) {
        return _entityTenantContainer;
      }
      if (auto myManager = cast(IEntityTenantManager)this.manager) {
        return myManager.entityTenantContainer;
      }
      
      return null;  
    }  

    void entityTenantContainer(DEntityTenantContainer aEntityTenantContainer) {    
      _entityTenantContainer = aEntityTenantContainer;
    }  
  // #endregion tenantContainer
}

mixin template EntityTenantManagerTemplate() {
  // #region get tenant
    IEntityTenant[] entityTenants() {
      if (entityTenantContainer is null) { return null; }

      return entityTenantContainer.values;
    }

    string[] entityTenantNames() {
      if (entityTenantContainer is null) { return null; }

      return entityTenantContainer.keys;
    }

    IEntityTenant entityTenant(string aName) {      
      return (entityTenantContainer ? entityTenantContainer[aName] : null);
    }

    size_t countEntityTenants() {      
      if (entityTenantContainer is null) { return 0; }

      return entityTenantContainer.length;
    }
  // #endregion get tenant

  // #region hasEntityTenant
    bool hasEntityTenants(IEntityTenant[] someTenants...) {
      return hasEntityTenants(someTenants.dup);
    }

    bool hasEntityTenants(IEntityTenant[] someTenants) {
      if (someTenants.isEmpty) { return false; }

      return someTenants
        .filter!(tenant => hasEntityTenant(tenant))
        .count == someTenants.length;
    }

    bool hasEntityTenants(string[] someNames...) {
      return hasEntityTenants(someNames.dup);
    }

    bool hasEntityTenants(string[] someNames) {
      if (someNames.isEmpty) { return false; }

      return someNames
        .filter!(name => hasEntityTenant(name))
        .count == someNames.length;
    }

    bool hasEntityTenant(IEntityTenant aTenant) {
      return (aTenant? hasEntityTenant(aTenant.name) : false);
    }

    bool hasEntityTenant(string aName) {
      if (entityTenantContainer is null) { return false; }

      return entityTenantContainer.contains(aName);
    }
  // #endregion hasEntityTenant

  // #region Add tenant 
    bool addEntityTenants(IEntityTenant[string] someTenants) {
      if (someTenants.isEmpty) { return false; }

      foreach(myName, myTenant; someTenants) {
        if (!addEntityTenant(myName, myTenant)) { return false; }
      }

      return true;
    }

    bool addEntityTenants(IEntityTenant[] someTenants...) {      
      return addEntityTenants(someTenants.dup);
    }

    bool addEntityTenants(IEntityTenant[] someTenants) {
      // Preconditions
      if (someTenants.isEmpty) { return false; }

      // Body & final
      return someTenants
        .count!(tenant => addEntityTenant(tenant)) == someTenants.length;
    }

    bool addEntityTenant(IEntityTenant aTenant) {
      return (aTenant ? addEntityTenant(aTenant.name, aTenant) : false);
    }

    bool addEntityTenant(string aName, IEntityTenant aTenant) {
      if (entityTenantContainer is null) { return false; }

      entityTenantContainer.add(aName, aTenant);
      return true; // TODO add should response with bool
    }
  // #endregion Add tenant

  // #region Update tenant
    bool updateEntityTenants(IEntityTenant[string] someTenants) {
      if (someTenants.isEmpty) { return false; }

      foreach(myName, myTenant; someTenants) {
        if (!updateEntityTenant(myName, myTenant)) { return false; }
      }

      return true;
    }

    bool updateEntityTenants(IEntityTenant[] someTenants...) {
      return updateEntityTenants(someTenants.dup);
    }

    bool updateEntityTenants(IEntityTenant[] someTenants) {
      if (someTenants.isEmpty) { return false; }

      // Body & final
      return someTenants
        .count!(tenant => updateEntityTenant(tenant)) == someTenants.length;
    }

    bool updateEntityTenant(IEntityTenant aTenant) {
      return (aTenant ? updateEntityTenant(aTenant.name, aTenant) : false);
    }
    bool updateEntityTenant(string aName, IEntityTenant aTenant) {
      if (entityTenantContainer is null) { return false; }

      entityTenantContainer.update(aName, aTenant);
      return true;
    }
  // #endregion Update tenant

  // #region Remove existing tenant
    bool removeEntityTenants(IEntityTenant[] someTenants...) {
      return removeEntityTenants(someTenants.dup);
    }

    bool removeEntityTenants(IEntityTenant[] someTenants) {
      // IN Check
      if (someTenants.isEmpty) { return false; }

      return someTenants
        .count!(tenant => removeEntityTenant(tenant)) == someTenants.length;
    }

    bool removeEntityTenants(string[] someNames...) {
      return removeEntityTenants(someNames.dup);
    }

    bool removeEntityTenants(string[] someNames) {
      if (someNames.isEmpty) { return false; }

      return someNames
        .map!(name => removeEntityTenant(name)).sum == someNames.length;
    }

    bool removeEntityTenant(IEntityTenant aTenant) {
      return (aTenant ? removeEntityTenant(aTenant.name) : false);
    }

    bool removeEntityTenant(string aName) {
      if (entityTenantContainer is null) { return false; }

      entityTenantContainer.remove(aName);
      return true;
    }
  // #endregion Remove tenant
}
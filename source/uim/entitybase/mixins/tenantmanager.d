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
      return (entityTenantContainer ? entityTenantContainer.values : null);
    }

    string[] entityTenantNames() {
      return (entityTenantContainer ? entityTenantContainer.keys : null);
    }

    IEntityTenant entityTenant(string aName) {      
      return (entityTenantContainer ? entityTenantContainer[aName] : null);
    }

    size_t countEntityTenants() {      
      return (entityTenantContainer ? entityTenantContainer.length : 0);
    }
  // #endregion get tenant

  // #region hasEntityTenant
    bool hasEntityTenants(IEntityTenant[] someTenants...) {
      return hasEntityTenants(someTenants.dup);
    }

    bool hasEntityTenants(IEntityTenant[] someTenants) {
      if (someTenants.isEmpty) return false;

      foreach(myTenant; someTenants) {
        if (!hasEntityTenant(myTenant)) {
          return false;
        }
      }
      return true;
    }

    bool hasEntityTenants(string[] someNames...) {
      return hasEntityTenants(someNames.dup);
    }

    bool hasEntityTenants(string[] someNames) {
      if (someNames.isEmpty) return false;

      foreach(myName; someNames) {
        if (!hasEntityTenant(myName)) {
          return false;
        }
      }

      return true;
    }

    bool hasEntityTenant(IEntityTenant aTenant) {
      return (aTenant? hasEntityTenant(aTenant.name) : false);
    }

    bool hasEntityTenant(string aName) {
      return (entityTenantContainer ? entityTenantContainer.contains(aName) : false);
    }
  // #endregion hasEntityTenant

  // #region Add tenant 
    bool addEntityTenants(IEntityTenant[string] someTenants) {
      if (someTenants.isEmpty) return false;

      foreach(myName, myTenant; someTenants) {
        if (!addEntityTenant(myName, myTenant)) return false;
      }

      return true;
    }

    bool addEntityTenants(IEntityTenant[] someTenants...) {
      return addEntityTenants(someTenants.dup);
    }

    bool addEntityTenants(IEntityTenant[] someTenants) {
      if (someTenants.isEmpty) return false;

      foreach(myTenant; someTenants) {
        if (!addEntityTenant(myTenant)) return false;
      }

      return true;
    }

    bool addEntityTenant(IEntityTenant aTenant) {
      return (aTenant ? addEntityTenant(aTenant.name, aTenant) : false);
    }

    bool addEntityTenant(string aName, IEntityTenant aTenant) {
      if (entityTenantContainer) {
        entityTenantContainer.add(aName, aTenant);
        return true;
      }

      return false;
    }
  // #endregion Add tenant

  // #region Update tenant
    bool updateEntityTenants(IEntityTenant[string] someTenants) {
    if (someTenants.isEmpty) return false;

    foreach(myName, myTenant; someTenants) {
      if (!updateEntityTenant(myName, myTenant)) return false;
    }

    return true;
  }

  bool updateEntityTenants(IEntityTenant[] someTenants...) {
    return updateEntityTenants(someTenants.dup);
  }

  bool updateEntityTenants(IEntityTenant[] someTenants) {
    if (someTenants.isEmpty) return false;

    foreach(myTenant; someTenants) {
      if (!updateEntityTenant(myTenant)) return false;
    }

    return true;
  }

  bool updateEntityTenant(IEntityTenant aTenant) {
    return (aTenant ? updateEntityTenant(aTenant.name, aTenant) : false);
  }
  bool updateEntityTenant(string aName, IEntityTenant aTenant) {
    if (entityTenantContainer) {
      entityTenantContainer.update(aName, aTenant); 
      return true;
    }
    return false;
  }
  // #endregion Update tenant

  // #region Remove existing tenant
    bool removeEntityTenants(IEntityTenant[] someTenants...) {
      return removeEntityTenants(someTenants.dup);
    }

    bool removeEntityTenants(IEntityTenant[] someTenants) {
      if (someTenants.isEmpty) return false;

      foreach(myTenant; someTenants) {
        if (!removeEntityTenant(myTenant)) return false;
      }
      return true;
    }

    bool removeEntityTenants(string[] someNames...) {
      return removeEntityTenants(someNames.dup);
    }

    bool removeEntityTenants(string[] someNames) {
      if (someNames.isEmpty) return false;

      foreach(myName; someNames) {
        if (!removeEntityTenant(myName)) return false;
      }

      return true;
    }

    bool removeEntityTenant(IEntityTenant aTenant) {
      return (aTenant ? removeEntityTenant(aTenant.name) : false);
    }

    bool removeEntityTenant(string aName) {
      if (entityTenantContainer) {
        entityTenantContainer.remove(aName);
        return true;
      }
      return false;
    }
  // #endregion Remove tenant
}
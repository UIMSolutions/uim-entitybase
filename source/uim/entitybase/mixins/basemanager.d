/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.basemanager;

import uim.entitybase;
@safe:

mixin template EntityBaseContainerTemplate() {
  // #region controllerContainer
    protected DEntityBaseContainer _entityBaseContainer;  
    DEntityBaseContainer entityBaseContainer() {
      if (entityBaseContainer) {
        return _entityBaseContainer;
      }
      if (auto myManager = cast(IEntityBaseManager)this.manager) {
        return myManager.entityBaseContainer;
      }
      
      return null; 
    }  

    void entityBaseContainer(DEntityBaseContainer aBaseContainer) {    
      _entityBaseContainer = aBaseContainer;
    }  
  // #endregion controllerContainer
}

mixin template EntityBaseManagerTemplate() {
  // #region entityBases
    IEntityBase[] entityBases() { 
      return (entityBaseContainer ? entityBaseContainer.values : null); 
    }
    string[] entityBaseNames() {
      return (entityBaseContainer ? entityBaseContainer.keys : null);
    }
    size_t countEntityBase() {
      return (entityBaseContainer ? entityBaseContainer.length : 0);
    }
  // #endregion entityBases

  // #region entityBase
    IEntityBase entityBase(string aName) {
      return (entityBaseContainer ? entityBaseContainer[aName] : null);
    }
  // #endregion entityBase

  // #region hasEntityBase
    bool hasEntityBases(IEntityBase[] someBases...) {
      return hasEntityBases(someBases.dup);
    }

    bool hasEntityBases(IEntityBase[] someBases) {
      if (someBases.isEmpty) { 
      return false; 
    }

      foreach(myBase; someBases) {
        if (!hasEntityBase(myBase)) { 
      return false; 
    }
      } 

      return true;
    }

    bool hasEntityBases(string[] someNames...) {
      return hasEntityBases(someBases.dup);
    }

    bool hasEntityBases(string[] someNames) {
      if (someBases.isEmpty) { 
      return false; 
    }

      foreach(myName; someNames) {
        if (!hasEntityBase(myName)) { 
      return false; 
    }
      } 

      return true;
    }

    bool hasEntityBase(IEntityBase aBase) {
      return (aBase ? hasEntityBase(aBase.name) : false);
    }
    bool hasEntityBase(string aName) {
      return (entityBaseContainer ? entityBaseContainer.contains(aName) : false);
    }
  // #region add EntityBase

  // #region add EntityBase
    bool entityBases(IEntityBase[string] someBases) {
      someBases.byKeyValue.each!(ky => entityBase(k, v));
    }

    bool addEntityBases(IEntityBase[] someBases...) {
      return addEntityBases(someBases.dup);
    }

    bool addEntityBases(IEntityBase[] someBases) {
      if (someBases.isEmpty) { 
      return false; 
    }

      foreach(myBase; someBases) {
        if (!hasEntityBase(myBase)) { 
      return false; 
    }
      } 

      return true;
    }

    bool addEntityBase(IEntityBase aBase) {
      return (aBase ? addEntityBase(aBase.name, aBase) : false);
    }
    bool addEntityBase(string aName, IEntityBase aEntityBase) {
      if (_entityBaseContainer && aEntityBase && !hasEntityBase(aName)) 
        _entityBaseContainer.add(aName, aEntityBase);
    }
  // #endregion add EntityBase

  // #region Update entityBase
    bool updateEntityBases(IEntityBase[] someBases...) {
      return updateEntityBases(addEntityBases);
    }
    bool updateEntityBases(IEntityBase[] someBases) {
    if (someNames.isEmpty) { 
      return false; 
    }

    foreach(myName; someNames) {
      if (!updateEntityBase(myName)) { 
      return false; 
    }
    } 

    return true;
  }

  bool updateEntityBases(string[] someNames...) {
    return updateEntityBases(someNames.dup);
  }

  bool updateEntityBases(string[] someNames) {
    if (someNames.isEmpty) { 
      return false; 
    }

    foreach(myName; someNames) {
      if (!updateEntityBase(myName)) { 
      return false; 
    }
    } 

    return true;
  }

  bool updateEntityBase(IEntityBase aBase) {
    return (aBase ? updateEntityBase(aBase.name, aBase) : false);
  }

  bool updateEntityBase(string aName, IEntityBase aEntityBase) {
    return (entityBaseContainer ? entityBaseContainer.update(aName, aEntityBase) : false);
  }
  // #endregion Update entityBase

  // #region Remove entityBase
    bool removeEntityBases(IEntityBase[] someBases...) {
      return removeEntityBases(addEntityBases);
    }
    bool removeEntityBases(IEntityBase[] someBases) {
    if (someNames.isEmpty) { 
      return false; 
    }

    foreach(myName; someNames) {
      if (!removeEntityBase(myName)) { 
      return false; 
    }
    } 

    return true;
  }

  bool removeEntityBases(string[] someNames...) {
    return removeEntityBases(someNames.dup);
  }

  bool removeEntityBases(string[] someNames) {
    if (someNames.isEmpty) { 
      return false; 
    }

    foreach(myName; someNames) {
      if (!removeEntityBase(myName)) { 
      return false; 
    }
    } 

    return true;
  }

  bool removeEntityBase(IEntityBase aEntityBase) {
    return (aEntityBase ? removeEntityBase(aEntityBase.name) : true);
  }

  bool removeEntityBase(string aName) {
    return (entityBaseContainer ? entityBaseContainer.remove(aName) : true);
  }
  // #endregion Remove entityBase
}
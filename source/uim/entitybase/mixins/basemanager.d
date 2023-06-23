/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.basemanager;

import uim.entitybase;
@safe:

mixin template EntityBaseManagerTemplate() {

  // #region entityBaseContainer
    protected DEntityBaseContainer _entityBaseContainer;

    void entityBaseContainer(DEntityBaseContainer aContainer) {
      _entityBaseContainer = aContainer;
    }
    DEntityBaseContainer entityBaseContainer() { 
      return _entityBaseContainer; 
    }
  // #endregion entityBaseContainer

  // #region entityBases
    void entityBases(IEntityBase[string] someBases) {
      someBases.byKeyValue.each!(ky => entityBase(k, v));
    }

    void entityBases(IEntityBase[] someBases) {
      someBases.each!(col => entityBase(col));
    }

    IEntityBase[] entityBases() { 
      if (_entityBaseContainer) return _entityBaseContainer.values;
      return null; 
    }
    string[] baseNames() {
      if (_entityBaseContainer) return _entityBaseContainer.keys;
      return null;
    }
  // #endregion entityBases

  // #region entityBase
    IEntityBase entityBase(string aName) {
      if (_entityBaseContainer) return _entityBaseContainer[aName];
      return null;
    }
    void entityBase(string aName, IEntityBase aEntityBase) {
      if (_entityBaseContainer) _entityBaseContainer[aName] = aEntityBase;
    }
  // #endregion entityBase

  // #region hasEntityBase
    bool hasEntityBase(IEntityBase aEntityBase) {
      if (aEntityBase) return hasEntityBase(aEntityBase.name);
      return false;
    }
    bool hasEntityBase(string aName) {
      if (_entityBaseContainer) return _entityBaseContainer.contains(aName);
      return false;
    }
  // #endregion hasEntityBase

  // Add entityBase if not exitst
  void addEntityBase(IEntityBase aEntityBase) {
    if (aEntityBase) addEntityBase(aEntityBase.name, aEntityBase);
  }
  void addEntityBase(string aName, IEntityBase aEntityBase) {
    if (_entityBaseContainer && aEntityBase && !hasEntityBase(aName)) 
      _entityBaseContainer.add(aName, aEntityBase);
  }

  // Update existing entityBase
  void updateEntityBase(IEntityBase aEntityBase) {
     if (aEntityBase) updateEntityBase(aEntityBase.name, aEntityBase);
  }
  void updateEntityBase(string aName, IEntityBase aEntityBase) {
    if (aEntityBase && hasEntityBase(aName)) _entityBaseContainer.update(aName, aEntityBase);
  }

  // Remove existing entityBase
  void removeEntityBase(IEntityBase aEntityBase) {
    if (aEntityBase) removeEntityBase(aEntityBase.name);
  }
  void removeEntityBase(string aName) {
    if (_entityBaseContainer && hasEntityBase(aName)) _entityBaseContainer.remove(aName);
  }

  // Operator overloading
  IEntityBase opIndex(string aName) {
    return entityBase(aName);
  }
  void opIndexAssign(IEntityBase aEntityBase, string aName) {
    addEntityBase(aName, aEntityBase);  
  }
}
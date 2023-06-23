/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.collectionmanager;

import uim.entitybase;
@safe:

mixin template EntityCollectionManagerTemplate() {

  // #region entityCollectionContainer
    protected DEntityCollectionContainer _entityCollectionContainer;

    void entityCollectionContainer(DEntityCollectionContainer aContainer) {
      _entityCollectionContainer = aContainer;
    }
    DEntityCollectionContainer entityCollectionContainer() { 
      return _entityCollectionContainer; 
    }
  // #endregion entityCollectionContainer

  // #region entityCollections
    void entityCollections(IEntityCollection[string] someCollections) {
      someCollections.byKeyValue.each!(ky => entityCollection(k, v));
    }

    void entityCollections(IEntityCollection[] someCollections) {
      someCollections.each!(col => entityCollection(col));
    }

    IEntityCollection[] entityCollections() { 
      if (_entityCollectionContainer) return _entityCollectionContainer.values;
      return null; 
    }
    string[] collectionNames() {
      if (_entityCollectionContainer) return _entityCollectionContainer.keys;
      return null;
    }
  // #endregion entityCollections

  // #region entityCollection
    IEntityCollection entityCollection(string aName) {
      if (_entityCollectionContainer) return _entityCollectionContainer[aName];
      return null;
    }
    void entityCollection(string aName, IEntityCollection aEntityCollection) {
      if (_entityCollectionContainer) _entityCollectionContainer[aName] = aEntityCollection;
    }
  // #endregion entityCollection

  // #region hasEntityCollection
    bool hasEntityCollection(IEntityCollection aEntityCollection) {
      if (aEntityCollection) return hasEntityCollection(aEntityCollection.name);
      return false;
    }
    bool hasEntityCollection(string aName) {
      if (_entityCollectionContainer) return _entityCollectionContainer.contains(aName);
      return false;
    }
  // #endregion hasEntityCollection

  // Add entityCollection if not exitst
  void addEntityCollection(IEntityCollection aEntityCollection) {
    if (aEntityCollection) addEntityCollection(aEntityCollection.name, aEntityCollection);
  }
  void addEntityCollection(string aName, IEntityCollection aEntityCollection) {
    if (_entityCollectionContainer && aEntityCollection && !hasEntityCollection(aName)) 
      _entityCollectionContainer.add(aName, aEntityCollection);
  }

  // Update existing entityCollection
  void updateEntityCollection(IEntityCollection aEntityCollection) {
     if (aEntityCollection) updateEntityCollection(aEntityCollection.name, aEntityCollection);
  }
  void updateEntityCollection(string aName, IEntityCollection aEntityCollection) {
    if (aEntityCollection && hasEntityCollection(aName)) _entityCollectionContainer.update(aName, aEntityCollection);
  }

  // Remove existing entityCollection
  void removeEntityCollection(IEntityCollection aEntityCollection) {
    if (aEntityCollection) removeEntityCollection(aEntityCollection.name);
  }
  void removeEntityCollection(string aName) {
    if (_entityCollectionContainer && hasEntityCollection(aName)) _entityCollectionContainer.remove(aName);
  }

  // Operator overloading
  IEntityCollection opIndex(string aName) {
    return entityCollection(aName);
  }
  void opIndexAssign(IEntityCollection aEntityCollection, string aName) {
    addEntityCollection(aName, aEntityCollection);  
  }
}
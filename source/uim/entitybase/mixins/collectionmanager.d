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

    void collectionContainer(DEntityCollectionContainer aContainer) {
      _entityCollectionContainer = aContainer;
    }
    DEntityCollectionContainer collectionContainer() { 
      return _entityCollectionContainer; 
    }
  // #endregion entityCollectionContainer

  // #region entityCollections
    void collections(IEntityCollection[string] someCollections) {
      someCollections.byKeyValue.each!(kv => collection(kv.key, kv.value));
    }

    void collections(IEntityCollection[] someCollections) {
      someCollections.each!(col => collection(col));
    }

    IEntityCollection[] collections() { 
      if (_entityCollectionContainer) return _entityCollectionContainer.values;
      return null; 
    }
    string[] collectionNames() {
      if (_entityCollectionContainer) return _entityCollectionContainer.keys;
      return null;
    }
  // #endregion entityCollections

  // #region entityCollection
    IEntityCollection collection(string aName) {
      if (_entityCollectionContainer) return _entityCollectionContainer[aName];
      return null;
    }
    void collection(IEntityCollection aEntityCollection) {
      if (aEntityCollection) collection(aEntityCollection.name, aEntityCollection);
    }
    void collection(string aName, IEntityCollection aEntityCollection) {
      if (_entityCollectionContainer) _entityCollectionContainer[aName] = aEntityCollection;
    }
  // #endregion entityCollection

  // #region hasEntityCollection
    bool hasCollection(IEntityCollection aEntityCollection) {
      if (aEntityCollection) return hasCollection(aEntityCollection.name);
      return false;
    }
    bool hasCollection(string aName) {
      if (_entityCollectionContainer) return _entityCollectionContainer.contains(aName);
      return false;
    }
  // #endregion hasEntityCollection

  // Add entityCollection if not exitst
  void addCollection(IEntityCollection aEntityCollection) {
    if (aEntityCollection) addCollection(aEntityCollection.name, aEntityCollection);
  }
  void addCollection(string aName, IEntityCollection aEntityCollection) {
    if (_entityCollectionContainer && aEntityCollection && !hasCollection(aName)) 
      _entityCollectionContainer.add(aName, aEntityCollection);
  }

  // Update existing entityCollection
  void updateCollection(IEntityCollection aEntityCollection) {
     if (aEntityCollection) updateCollection(aEntityCollection.name, aEntityCollection);
  }
  void updateCollection(string aName, IEntityCollection aEntityCollection) {
    if (aEntityCollection && hasCollection(aName)) _entityCollectionContainer.update(aName, aEntityCollection);
  }

  // Remove existing entityCollection
  void removeCollection(IEntityCollection aEntityCollection) {
    if (aEntityCollection) removeCollection(aEntityCollection.name);
  }
  void removeCollection(string aName) {
    if (_entityCollectionContainer && hasCollection(aName)) _entityCollectionContainer.remove(aName);
  }

  // Operator overloading
  IEntityCollection opIndex(string aName) {
    return collection(aName);
  }
  void opIndexAssign(IEntityCollection aEntityCollection, string aName) {
    addCollection(aName, aEntityCollection);  
  }
}
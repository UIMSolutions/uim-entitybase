/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.mixins.collectionmanager;

import uim.entitybase;
@safe:

mixin template EntityCollectionContainerTemplate() {
  // #region EntityCollectionContainer
    protected DEntityCollectionContainer _entityCollectionContainer;  
    DEntityCollectionContainer entityCollectionContainer() {
      if (entityCollectionContainer) {
        return _entityCollectionContainer;
      }
      if (auto myManager = cast(IEntityCollectionManager)this.manager) {
        return myManager.entityCollectionContainer;
      }
      
      return null; 
    }  
    void entityCollectionContainer(DEntityCollectionContainer aContainer) {    
      _entityCollectionContainer = aContainer;
    }  
  // #endregion EntityCollectionContainer
}

mixin template EntityCollectionManagerTemplate() {
  // #region entityEntityCollection
    IEntityCollection[] entityCollections() { 
      if (entityCollectionContainer) return entityCollectionContainer.values;
      return null; 
    }

    string[] entityCollectionNames() {
      return (entityCollectionContainer ? entityCollectionContainer.keys : null);
    }

    size_t countEntityCollections() {
      return (entityCollectionContainer ? entityCollectionContainer.length : 0);
    }
  // #endregion entityEntityCollection

  // #region entityCollection
    IEntityCollection entityCollection(string aName) {
      return (entityCollectionContainer ? entityCollectionContainer[aName] : null);
    }
  // #endregion entityCollection

  // #region hasEntityCollection
    bool hasEntityCollections(IEntityCollection[] someCollections...) {
      return hasEntityCollections(someCollections.dup);
    }

    bool hasEntityCollections(IEntityCollection[] someCollections) {
      if (someCollections.isEmpty) { 
      return false; 
    }

      foreach(myCollection; someCollections) {
        if (!hasEntityCollection(myCollection)) {
          return false;
        } 
      }
      return true;
    }

    bool hasEntityCollections(string[] someNames...) {
      return hasEntityCollections(someNames.dup);
    }

    bool hasEntityCollections(string[] someNames) {
      if (someNames.isEmpty) { 
      return false; 
    }

      return someNames
        .filter!(n => hasEntityCollection(n))
        .array.length == someNames.length;
    }

    bool hasEntityCollection(IEntityCollection aCollection) {
      return (aCollection ? hasEntityCollection(aCollection.name) : false);
    }

    bool hasEntityCollection(string aName) {
      return (entityCollectionContainer ? entityCollectionContainer.contains(aName) :false);
    }
  // #endregion hasEntityCollection

  // #region Add collection 
    bool addEntityCollections(IEntityCollection[string] someCollections) {
      if (someCollections.isEmpty) { 
      return false; 
    }

      foreach(myName, myCollection; someCollections) {
        if (!addEntityCollection(myName, myCollection)) { 
      return false; 
    }
      }

      return true;
    }

    bool addEntityCollections(IEntityCollection[] someCollections...) {
      return addEntityCollections(someCollections.dup);
    }

    bool addEntityCollections(IEntityCollection[] someCollections) {
      if (someCollections.isEmpty) { 
      return false; 
    }

      return someCollections
        .filter!(c => addEntityCollection(c))
        .array.length == someCollections.length;
    }

    bool addEntityCollection(IEntityCollection aCollection) {
      return (aCollection 
        ? addEntityCollection(aCollection.name, aCollection) 
        : false);
    }

    bool addEntityCollection(string aName, IEntityCollection aCollection) {
      return entityCollectionContainer
        ? entityCollectionContainer.add(aName, aCollection)
        : false;
    }
  // #endregion Add collection

  // #region Update collection
    bool updateEntityCollections(IEntityCollection[string] someCollections) {
    if (someCollections.isEmpty) { 
      return false; 
    }

    foreach(myName, myCollection; someCollections) {
      if (!updateEntityCollection(myName, myCollection)) { 
      return false; 
    }

    return true;
  }

  bool updateEntityCollections(IEntityCollection[] someCollections...) {
    return updateEntityCollections(someCollections.dup);
  }

  bool updateEntityCollections(IEntityCollection[] someCollections) {
    if (someCollections.isEmpty) { 
      return false; 
    }

    return someCollections
      .filter!(c => updateEntityCollection(c))
      .array.length == someCollections.length;
    }
  }

  bool updateEntityCollection(IEntityCollection aCollection) {
    return (aCollection ? updateEntityCollection(aCollection.name, aCollection) : false);
  }
  bool updateEntityCollection(string aName, IEntityCollection aCollection) {
    if (aName.isEmpty || aCollection.isNull) {
      return false;
    }

    if (entityCollectionContainer.isNull) {
      return false;
    }

    entityCollectionContainer.update(aName, aCollection);
    return true;
  }
  // #endregion Update collection

  // #region Remove existing collection
    bool removeEntityCollections(IEntityCollection[] someCollections...) {
      return removeEntityCollections(someCollections.dup);
    }

    bool removeEntityCollections(IEntityCollection[] someCollections) {
      if (someCollections.isEmpty) { 
        return false; 
      }

      foreach(myCollection; someCollections) {
        if (!removeEntityCollection(myCollection)) { return false; }
      }
      return true;
    }

    bool removeEntityCollections(string[] someNames...) {
      return removeEntityCollections(someNames.dup);
    }

    bool removeEntityCollections(string[] someNames) {
      if (someNames.isEmpty) { 
        return false; 
      }

      foreach(myName; someNames) {
        if (!removeEntityCollection(myName)) { return false; }
      }

      return true;
    }

    bool removeEntityCollection(IEntityCollection aCollection) {
      return (aCollection ? removeEntityCollection(aCollection.name) : false);
    }

    bool removeEntityCollection(string aName) {
      if (entityCollectionContainer) {
        entityCollectionContainer.remove(aName);
        return true;
      } 

      return false;
    }
  // #endregion Remove collection
}
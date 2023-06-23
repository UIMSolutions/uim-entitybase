module uim.entitybase.interfaces.collectionmanager;

@safe:
import uim.entitybase;

interface IEntityCollectionManager {
  void entityCollections(DEntityCollectionContainer aContainer);
  DEntityCollectionContainer entityCollections();

  IEntityCollection entityCollection(string[string] options);
  IEntityCollection entityCollection(string aName);

  bool existsEntityCollection(IEntityCollection aCollection);
  bool existsEntityCollection(string aName);

  void addEntityCollection(IEntityCollection aCollection);
  void addEntityCollection(string aName, IEntityCollection aCollection);

  // Update existing entitycollection
  void updateEntityCollection(IEntityCollection aCollection);
  void updateEntityCollection(string aName, IEntityCollection aCollection);

  // Remove existing entitycollection
  void removeEntityCollection(IEntityCollection aCollection);
  void removeEntityCollection(string aName);
}
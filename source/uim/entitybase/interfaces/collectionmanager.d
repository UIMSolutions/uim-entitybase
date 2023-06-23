/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.interfaces.collectionmanager;

@safe:
import uim.entitybase;

interface IEntityCollectionManager {
  void entityCollectionContainer(DEntityCollectionContainer aContainer);
  DEntityCollectionContainer entityCollectionContainer();

  void entityCollections(IEntityCollection[string] someCollections);
  void entityCollections(IEntityCollection[] someCollections);
  IEntityCollection[] entityCollections();
  string[] collectionNames();

  // set & get entitycollection
  IEntityCollection entityCollection(string aName);
  void entityCollection(string aName, IEntityCollection aEntityCollection);

  // Check existing entitycollection
  bool hasEntityCollection(IEntityCollection aCollection);
  bool hasEntityCollection(string aName);

  // Add new entitycollection without overwriting
  void addEntityCollection(IEntityCollection aCollection);
  void addEntityCollection(string aName, IEntityCollection aCollection);

  // Update existing entitycollection
  void updateEntityCollection(IEntityCollection aCollection);
  void updateEntityCollection(string aName, IEntityCollection aCollection);

  // Remove existing entitycollection
  void removeEntityCollection(IEntityCollection aCollection);
  void removeEntityCollection(string aName);

  // operator overloading
  IEntityCollection opIndex(string aName);
  void opIndexAssign(IEntityCollection aCollection, string aName);
}
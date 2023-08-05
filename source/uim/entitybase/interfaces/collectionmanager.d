/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.interfaces.collectionmanager;

@safe:
import uim.entitybase;

interface IEntityCollectionManager {
  DEntityCollectionContainer entityCollectionContainer();

  // Get
  IEntityCollection[] entityCollections();
  string[] entityCollectionNames();
  size_t countEntityCollections();
  IEntityCollection entityCollection(string aName);

  // Check existing entitycollection
  bool hasEntityCollections(IEntityCollection[] someCollections...);
  bool hasEntityCollections(IEntityCollection[] someCollections);

  bool hasEntityCollections(string[] someNames...);
  bool hasEntityCollections(string[] someNames);

  bool hasEntityCollection(IEntityCollection aCollection);
  bool hasEntityCollection(string aName);

  // Add new entitycollection without overwriting
  bool addEntityCollections(IEntityCollection[] someCollections...);
  bool addEntityCollections(IEntityCollection[] someCollections);
  bool addEntityCollections(IEntityCollection[string] someCollections);

  bool addEntityCollection(IEntityCollection aCollection);
  bool addEntityCollection(string aName, IEntityCollection aCollection);

  // Update existing entitycollection
  bool updateEntityCollections(IEntityCollection[] someCollections...);
  bool updateEntityCollections(IEntityCollection[] someCollections);
  bool updateEntityCollections(IEntityCollection[string] someCollections);

  bool updateEntityCollection(IEntityCollection aCollection);
  bool updateEntityCollection(string aName, IEntityCollection aCollection);

  // Remove existing entitycollection
  bool removeEntityCollections(IEntityCollection[] someCollections...);
  bool removeEntityCollections(IEntityCollection[] someCollections);

  bool removeEntityCollections(string[] someNames...);
  bool removeEntityCollections(string[] someNames);

  bool removeEntityCollection(IEntityCollection aCollection);
  bool removeEntityCollection(string aName);
}
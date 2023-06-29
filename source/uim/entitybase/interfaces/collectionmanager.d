/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.entitybase.interfaces.collectionmanager;

@safe:
import uim.entitybase;

interface IEntityCollectionManager {
  void collectionContainer(DEntityCollectionContainer aContainer);
  DEntityCollectionContainer collectionContainer();

  void collections(IEntityCollection[string] someCollections);
  void collections(IEntityCollection[] someCollections);
  IEntityCollection[] collections();
  string[] collectionNames();

  // set & get entitycollection
  IEntityCollection collection(string aName);
  void collection(string aName, IEntityCollection aCollection);

  // Check existing entitycollection
  bool hasCollection(IEntityCollection aCollection);
  bool hasCollection(string aName);

  // Add new entitycollection without overwriting
  void addCollection(IEntityCollection aCollection);
  void addCollection(string aName, IEntityCollection aCollection);

  // Update existing entitycollection
  void updateCollection(IEntityCollection aCollection);
  void updateCollection(string aName, IEntityCollection aCollection);

  // Remove existing entitycollection
  void removeCollection(IEntityCollection aCollection);
  void removeCollection(string aName);

  // operator overloading
  IEntityCollection opIndex(string aName);
  void opIndexAssign(IEntityCollection aCollection, string aName);
}
module uim.entitybase.interfaces.basemanager;

@safe:
import uim.entitybase;

interface IEntityBaseManager {
  DEntityBaseContainer entityBaseContainer();

  IEntityBase[] entityBases();
  string[] baseNames();
  size_t countEntityBases();

  // get entitybase
  IEntityBase entityBase(string aName);

  // Check existing entitybase
  bool hasEntityBases(IEntityBase[] someBases...);
  bool hasEntityBases(IEntityBase[] someBases);

  bool hasEntityBases(string[] someNames...);
  bool hasEntityBases(string[] someNames);
  
  bool hasEntityBase(IEntityBase aBase);
  bool hasEntityBase(string aName);

  // Add new entitybase without overwriting
  bool addEntityBases(IEntityBase[string] someBases);
  bool addEntityBases(IEntityBase[] someBases...);
  bool addEntityBases(IEntityBase[] someBases);

  bool addEntityBase(IEntityBase aBase);
  bool addEntityBase(string aName, IEntityBase aBase);

  // Update existing entitybase
  bool updateEntityBases(IEntityBase[string] someBases);
  bool updateEntityBases(IEntityBase[] someBases...);
  bool updateEntityBases(IEntityBase[] someBases);

  bool updateEntityBase(IEntityBase aBase);
  bool updateEntityBase(string aName, IEntityBase aBase);

  // Remove existing entitybase
  bool removeEntityBases(IEntityBase[string] someBases);
  bool removeEntityBases(IEntityBase[] someBases...);
  bool removeEntityBases(IEntityBase[] someBases);

  bool removeEntityBase(IEntityBase aBase);
  bool removeEntityBase(string aName);
}
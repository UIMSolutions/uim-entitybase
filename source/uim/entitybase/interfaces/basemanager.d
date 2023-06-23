module uim.entitybase.interfaces.basemanager;

@safe:
import uim.entitybase;

interface IEntityBaseManager {
  void entityBaseContainer(DEntityBaseContainer aContainer);
  DEntityBaseContainer entityBaseContainer();

  void entityBases(IEntityBase[string] someBases);
  void entityBases(IEntityBase[] someBases);
  IEntityBase[] entityBases();
  string[] baseNames();

  // set & get entitybase
  IEntityBase entityBase(string aName);
  void entityBase(string aName, IEntityBase aEntityBase);

  // Check existing entitybase
  bool hasEntityBase(IEntityBase aBase);
  bool hasEntityBase(string aName);

  // Add new entitybase without overwriting
  void addEntityBase(IEntityBase aBase);
  void addEntityBase(string aName, IEntityBase aBase);

  // Update existing entitybase
  void updateEntityBase(IEntityBase aBase);
  void updateEntityBase(string aName, IEntityBase aBase);

  // Remove existing entitybase
  void removeEntityBase(IEntityBase aBase);
  void removeEntityBase(string aName);

  // operator overloading
  IEntityBase opIndex(string aName);
  void opIndexAssign(IEntityBase aBase, string aName);
}
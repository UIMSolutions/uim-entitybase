module uim.entitybase.interfaces.basemanager;

@safe:
import uim.entitybase;

interface IEntityBaseManager {
  void entityBases(DEntityBaseContainer aContainer);
  DEntityBaseContainer entityBases();

  IEntityBase entityBase(string[string] options);
  IEntityBase entityBase(string aName);

  bool existsEntityBase(IEntityBase aBase);
  bool existsEntityBase(string aName);

  void addEntityBase(IEntityBase aBase);
  void addEntityBase(string aName, IEntityBase aBase);

  // Update existing entitybase
  void updateEntityBase(IEntityBase aBase);
  void updateEntityBase(string aName, IEntityBase aBase);

  // Remove existing entitybase
  void removeEntityBase(IEntityBase aBase);
  void removeEntityBase(string aName);
}
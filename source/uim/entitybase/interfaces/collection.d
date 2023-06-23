module uim.entitybase.interfaces.collection;

@safe:
import uim.entitybase;

interface IEntityCollection {
  string name();

  // Count items in the collection 
  size_t count(bool allVersions = false);
  size_t count(UUID id, bool allVersions = false);
  size_t count(UUID[] ids, size_t versionNumber);
  size_t count(UUID id, size_t versionNumber);
  size_t count(STRINGAA[] selects, bool allVersions = false);
  size_t count(STRINGAA select, bool allVersions = false);
  size_t count(Json[] selects, bool allVersions = false);
  size_t count(Json select, bool allVersions = false);

  // findMany
  DEntity[] findMany(bool allVersions = false);
  DEntity[] findMany(UUID[] ids, bool allVersions = false);
  DEntity[] findMany(UUID id, bool allVersions = false);
  DEntity[] findMany(UUID[] ids, size_t versionNumber);
  DEntity[] findMany(STRINGAA[] selects, bool allVersions = false);
  DEntity[] findMany(STRINGAA select, bool allVersions = false);
  DEntity[] findMany(Json[] selects, bool allVersions = false);
  DEntity[] findMany(Json select, bool allVersions = false);

  // findOne
  DEntity findOne(UUID[] ids, bool allVersions = false);
  DEntity findOne(UUID id, bool allVersions = false);
  DEntity findOne(UUID[] ids, size_t versionNumber);
  DEntity findOne(UUID id, size_t versionNumber);
  DEntity findOne(STRINGAA[] selects, bool allVersions = false);
  DEntity findOne(STRINGAA select, bool allVersions = false);
  DEntity findOne(Json[] selects, bool allVersions = false);
  DEntity findOne(Json select, bool allVersions = false);

  // insertOne
  DEntity insertOne(DEntity entity);
  DEntity insertOne(Json newData);

  // updateMany
  size_t updateMany(STRINGAA select, STRINGAA updateData); 
  size_t updateMany(STRINGAA select, Json updateData);
  size_t updateMany(Json select, STRINGAA updateData);
  size_t updateMany(Json select, Json updateData);

  // updateOne
  bool updateOne(DEntity entity);
  bool updateOne(STRINGAA select, STRINGAA updateData);
  bool updateOne(STRINGAA select, Json updateData);
  bool updateOne(Json select, STRINGAA updateData);
  bool updateOne(Json select, Json updateData);

  // removeMany
  size_t removeMany(DEntity[] entities, bool allVersions = false);
  size_t removeMany(DEntity entity, bool allVersions = false);
  size_t removeMany(UUID[] ids, bool allVersions = false);
  size_t removeMany(UUID id, bool allVersions = false);
  size_t removeMany(UUID[] ids, size_t versionNumber);
  size_t removeMany(UUID id, size_t versionNumber);
  size_t removeMany(STRINGAA[] selects, bool allVersions = false);
  size_t removeMany(STRINGAA select, bool allVersions = false);
  size_t removeMany(Json[] selects, bool allVersions = false);
  size_t removeMany(Json select, bool allVersions = false);

  // removeOne
  bool removeOne(UUID[] ids, bool allVersions = false);
  bool removeOne(DEntity entity);
  bool removeOne(UUID id, bool allVersions = false);
  bool removeOne(UUID id, size_t versionNumber);
  bool removeOne(STRINGAA[] selects, bool allVersions = false);
  bool removeOne(STRINGAA select, bool allVersions = false);
  bool removeOne(DEntity[] entities);
  bool removeOne(Json[] selects, bool allVersions = false);
  bool removeOne(Json select, bool allVersions = false);
}
module uim.entitybase.classes.collections.tests;

@safe:
import uim.entitybase;

bool test_findMany(IJsonCollection col) {
  col.insertOne(toJson(randomUUID, 22));
  return col.findMany.length > 0;
}

bool test_findMany_allVersions(IJsonCollection col) {
  col.insertOne(toJson(randomUUID, 22));
  return col.findMany(true).length > 0;
}

bool test_findMany_id(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  col.insertOne(json);
  return col.findMany(UUID(json["id"].get!string)).length > 0;
}

bool test_findMany_id_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  col.insertOne(json);
  return col.findMany(UUID(json["id"].get!string), true).length > 0;
}

bool test_findMany_select(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findMany(["name":"test"]).length > 0;
}

bool test_findMany_select_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findMany(["name":"test"], true).length > 0;
}

bool test_findMany_jselect(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findMany(json).length > 0;
}

bool test_findMany_jselect_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findMany(json, true).length > 0;
}

bool test_findOne_id(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  col.insertOne(json);
  return col.findOne(UUID(json["id"].get!string)) != Json(null);
}

bool test_findOne_id_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  col.insertOne(json);
  return col.findOne(UUID(json["id"].get!string), true) != Json(null);
}

bool test_findOne_id_versionNumber(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  col.insertOne(json);
  return col.findOne(UUID(json["id"].get!string), 22) != Json(null);
}

bool test_findOne_select(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findOne(["name":"test"]) != Json(null);
}

bool test_findOne_select_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findOne(["name":"test"], true) != Json(null);
}

bool test_findOne_jselect(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findOne(json) != Json(null);
}

bool test_findOne_jselect_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  json["name"] = "test";
  col.insertOne(json);
  return col.findOne(json, true) != Json(null);
}

bool test_insertOne_data(IJsonCollection col) {
  auto json = toJson(randomUUID, 22);
  col.insertOne(json);
  return col.findOne(json) != Json(null);
}

bool test_updateMany_select_data(IJsonCollection col) {
  auto id = randomUUID;
  auto json1 = toJson(id, 22);
  col.insertOne(json1);
  auto json2 = toJson(id, 20);
  col.insertOne(json2);

  auto sel = ["id": id.toString];  
  col.updateMany(sel, ["name":"newName"]);
  return col.findMany(sel).length > 0;
}

bool test_updateMany_jselect_data(IJsonCollection col) {
  auto id = randomUUID;
  auto json1 = toJson(id, 22);
  col.insertOne(json1);
  auto json2 = toJson(id, 20);
  col.insertOne(json2);

  auto select = toJson(["id": id.toString]);  
  auto updateData = toJson(["name": "newName"]);  
  col.updateMany(select, updateData);
  return col.findMany(select).length > 0;
}

bool test_updateOne_select_data(IJsonCollection col) {
  auto id = randomUUID;
  auto json = toJson(id, 22);
  col.insertOne(json);

  auto select = ["id": id.toString];  
  col.updateOne(select, ["name":"newName"]);
  return col.findMany(select).length == 1;
}

bool test_updateOne_jselect_data(IJsonCollection col) {
  auto id = randomUUID;
  auto json = toJson(id, 22);
  col.insertOne(json);

  auto sel = toJson(["id": id.toString]);  
  col.updateOne(sel, toJson(["name":"newName"]));
  return col.findMany(sel).length == 1;
}

bool test_removeMany_id(IJsonCollection col) {
  auto id = randomUUID;
  auto json1 = toJson(id, 22);
  col.insertOne(json1);
  auto json2 = toJson(id, 20);
  col.insertOne(json2);
  return col.removeMany(id) == 1;
}

bool test_removeMany_id_allVersions(IJsonCollection col) {
  auto id = randomUUID;
  auto json1 = toJson(id, 22);
  col.insertOne(json1);
  auto json2 = toJson(id, 20);
  col.insertOne(json2);
  return col.removeMany(id, true) == 2;
}

bool test_removeMany_select(IJsonCollection col) {
  auto json = toJson(randomUUID, 20);
  col.insertOne(json);
  auto data = ["id": json["id"].get!string, "versionNumber":json["versionNumber"].toString];
  return col.removeMany(data) > 0;
}

bool test_removeMany_select_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 21);
  col.insertOne(json);
  auto data = ["id": json["id"].get!string];
  return col.removeMany(data) > 0;
}

bool test_removeMany_jselect(IJsonCollection col) {
  auto json = col.insertOne(toJson(randomUUID, 22));
  return col.removeMany(json) > 0;
}

bool test_removeMany_jselect_allVersions(IJsonCollection col) {
  auto json = col.insertOne(toJson(randomUUID, 23));
  return col.removeMany(UUID(json["id"].get!string)) > 0;
}

bool test_removeOne_id(IJsonCollection col) {
  auto json = toJson(randomUUID, 20);
  col.insertOne(json);
  return col.removeOne(UUID(json["id"].get!string));
}

bool test_removeOne_id_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 20);
  col.insertOne(json);
  return col.removeOne(UUID(json["id"].get!string), true);
}

bool test_removeOne_id_versionNumber(IJsonCollection col) {
  auto json = toJson(randomUUID, 20);
  col.insertOne(json);
  return col.removeOne(UUID(json["id"].get!string), json["versionNumber"].get!size_t);
}

bool test_removeOne_select(IJsonCollection col) {
  auto json = toJson(randomUUID, 20);
  col.insertOne(json);
  auto data = ["id": json["id"].get!string, "versionNumber":json["versionNumber"].toString];
  return col.removeOne(data);
}

bool test_removeOne_select_allVersions(IJsonCollection col) {
  auto json = toJson(randomUUID, 21);
  col.insertOne(json);
  auto data = ["id": json["id"].get!string];
  return col.removeOne(data);
}

bool test_removeOne_jselect(IJsonCollection col) {
  auto json = col.insertOne(toJson(randomUUID, 22));
  return col.removeOne(json);
}

bool test_removeOne_jselect_allVersions(IJsonCollection col) {
  auto json = col.insertOne(toJson(randomUUID, 23));
  return col.removeOne(UUID(json["id"].get!string));
}
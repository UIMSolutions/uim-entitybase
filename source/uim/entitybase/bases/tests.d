module uim.entitybase.bases.tests;

@safe:
import uim.entitybase;

auto createTestDB(string mode) {
  switch(mode) {
    case "file":
      auto jsBase = JSBFileBase("./tests");
      debug writeln("Tenants: ", jsBase.tenantNames);
      foreach(name, t; jsBase.tenants) debug writeln ("Collections in "~name~": ", t.collectionNames);
      return ETBBase(jsBase);
    //break;
    default: return ETBBase();
  }
}
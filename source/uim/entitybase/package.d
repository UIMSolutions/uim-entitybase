module uim.entitybase;

mixin(ImportPhobos!());

public import uim.core;
public import uim.oop;
public import uim.models;

// public import uim.domains;
public import uim.jsonbase;
public import uim.jsonbase;

public import vibe.data.json;

public { // Own Packages 
  import uim.entitybase.classes;
  import uim.entitybase.interfaces;
  import uim.entitybase.helpers;
  import uim.entitybase.tests;
}
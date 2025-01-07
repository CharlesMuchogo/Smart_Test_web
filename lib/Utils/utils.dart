const String baseUrl = "https://smarttest.muchogoc.com";


String capitalize(String name) {
  if (name.isEmpty) return name;
  return name[0].toUpperCase() + name.substring(1).toLowerCase();
}
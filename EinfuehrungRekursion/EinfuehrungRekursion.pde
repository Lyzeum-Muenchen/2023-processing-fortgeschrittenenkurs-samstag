
void setup() {
  int result = testMethod(0);
  println(result);
  // Integer.INT_VALUE
}
// Konzept von rekursiven Funktionen:
// - Funktion ruft sich selber auf
// Problem: Endlossschleife
int testMethod(int x) {
  if (x < 1000) {
    return testMethod(x + 1); // Abbruchbedingung, verhindert Endlosschleifen
  }
  return x;
}

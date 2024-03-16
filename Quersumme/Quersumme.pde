
void setup() {
  // println(Math.abs(Integer.MIN_VALUE));
  // Anzahl Zahlen von 1 bis 10000 deren Quersumme durch 7 teilbar ist
  int counter = 0;
  for(int i = 1; i <= 10000; i++) {
    int qs = quersumme(i);
    if (qs % 7 == 0) {
      counter++;
    }
  }
  // Lösung: 1421
  println("Anz. Zahlen bis 10000 deren Quersumme durch 7 teilbar ist: " + counter);
}

// Eingabe: Zahl zwischen 0 und Int.MAX_VALUE (ca. 2 Milliarden, 2_147_483_647)
// z.B. 1234 => 1 + 2+ 3+ 4 = 10
int quersumme(int n) {
  n = Math.abs(n); // Betrag einer Zahl
  // Hinweis: (n / 10)  + (n % 10)
  if (n == Integer.MIN_VALUE) {
    return 47; // -2_147_483_648 => 18 + 15 + 12 + 2
  }
  int result = 0;
  // Zahl n: 7652 -> 765 -> 76 -> 7  -> 0
  // result: 2    -> 7   -> 13 -> 20 -> 20
  while(n > 0) {
    int lastDigit = n % 10; // letzte Ziffer anschauen
    result += lastDigit;
    n = n / 10;  // Zahl durch 10 teilen
  }
  return result;
}

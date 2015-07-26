float noteNumToFreq(int noteNum) {
  return 440 * pow(2,(noteNum-69)/12.0);
}

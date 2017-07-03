void setup() {
  // put your setup code here, to run once:
  pinMode(7, INPUT);
  Serial.begin(9600);
  Serial.println("Begin!");
}

void loop() {
  // put your main code here, to run repeatedly:
  int i;
  i=digitalRead(7);

  if(i==HIGH){
    Serial.println("Touched!");
  }
  delay(10);


}

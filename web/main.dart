import 'dart:html';
import "random.dart";
Element output;
TextAreaElement textAreaElement;
void main() {
  output = querySelector('#output');
  textAreaElement = new TextAreaElement();
  String s = "Ask a question of Dennis.";

  textAreaElement.text = s;
  textAreaElement.rows = 15;
  textAreaElement.cols = 50;

  output.append(textAreaElement);

  ButtonElement button = new ButtonElement();
  button.text = "Ask.";

  window.onKeyDown.listen((KeyboardEvent e) {
    if(e.keyCode == 13) {
      dennis(); //arc number strikes again
    }
  });
  output.append(button);

  button.onClick.listen((e) {
    dennis();
  });
}

void dennis() {
  String sentence = textAreaElement.value;
  Element div = new DivElement();
  div.text = "${convertSentenceToDennisFact(sentence)}";
  output.append(div);
}

String convertSentenceToDennisFact(String sentence) {
  int seed = convertSentenceToNumber(sentence);
  Random rand = new Random(seed);
  List<String> _animals = <String>["dennis"];
  List<String> _bodyParts = <String>["sporty frock coat","frock coat","head","muscles","arms","brain","legs","feet","hands","eyes","jimberjam","jimberjam","jimberjam","ye flask","trinket","parapet","nice jimberjam"];
  List<String> _numbers = <String>["one","two","three","four","five","six","seven","eight","nine"];
  List<String> _unitsOfTime = <String>["second","minute","hour","day"];
  List<String> _unitsOfSpace = <String>["inch","foot"];
  List<String> _unitsOfSpacePlural = <String>["inches","feet"];

  List<String> _adjatives = <String>["huge","surprisingly tiny","fragrant","magical","lustful","delicious","aesthetically pleasing","the subject of many documentaries","rapturous","musical","slender","thick","thicc","heavy","musky","pungent","soft","hard","silky"];

  List<String> _actions = <String>["pace","fight","gigglesnort","pace about nervously","mate","laugh","squeal","chitter","growl"];
  List<String> _fakeAlts = <String>["foot","sensory organ","mouth","weapon","tongue"];

  List<String> _shapes = <String>["corkscrew","spiral","triangle","perfect cyllinder","square","helix"];
  List<String> _nouns = <String>["computers","cars","statues","town houses","apples","irony","doritos"];
  _nouns.addAll(_animals);
  _nouns.addAll(_bodyParts);


  String animal = rand.pickFrom(_animals);
  String adj = rand.pickFrom(_adjatives);

  String bodyPart = rand.pickFrom(_bodyParts);
  String fakeAlt = rand.pickFrom(_fakeAlts);


  String action = rand.pickFrom(_actions);
  String noun = rand.pickFrom(_nouns);
  String shape = rand.pickFrom(_shapes);



  String unitOfSpace = rand.pickFrom(_unitsOfSpace);

  String number = rand.pickFrom(_numbers);
  String unitOfTime = rand.pickFrom(_unitsOfTime);
  String bodyPartPlural = bodyPart;

  if(number != "one") {
    bodyPartPlural = "${bodyPart}s";
    unitOfSpace = rand.pickFrom(_unitsOfSpacePlural);
    unitOfTime = "${unitOfTime}s";

  }

//almost all species of JR gigglesnort when they taunt shoguns
  List<String> ret = <String>["$animal has a record $bodyPart length of $number $unitOfSpace ","$animal has something that looks like a $bodyPart but it's actually a $fakeAlt","$animal yells so loud you can hear it for miles","$animal nervously paces $number times a ${rand.pickFrom(_unitsOfTime)}","$animal has a prehensile $bodyPart","$animal $bodyPart explodes at the end of pacing","scientists have yet to record $animal pacing on film","scientists are testing how $animal paces nervously in space","$animal doesn't have ${bodyPart}s","$animal paces every other year","$animal pacing lasts $number $unitOfTime","$animal nervously pacing lasts $number $unitOfTime","$animal can have $bodyPart $number times a $unitOfTime","$animal are only active for a $number $unitOfTime window a year","$animal has a bone in their $bodyPart","nearly all manifestations of $animal are nervous","$animal invented a simple economy simply to get $bodyPartPlural","$animal pacing is said to be $adj","$animal gains one $bodyPart for every year of life","$animal will die after pacing $number times","$animal is nervously attracted to $noun","$animal showing a nervous $bodyPart is a sign of submission","$animal collects flasks of $number small $bodyPartPlural when it is time to pace","$animal can pace with $number $bodyPartPlural at once","$animal has a $adj $bodyPart","$animal can die if they don't get $bodyPart","$animal can control every single muscle of their $bodyPart ","$animal can pace $number $unitOfSpace into the air","$animal can wear $bodyPartPlural","$animal have a $number $unitOfSpace $bodyPart", "almost all manifestations of $animal $action when they see $noun ","$animal have $number ${bodyPartPlural}", "$animal thinks of pacing $number times a $unitOfTime", "$animal have a $shape $bodyPart","$animal is a place", "$animal has a nice $bodyPart"];


  return rand.pickFrom(ret);

}

int convertSentenceToNumber(String sentence) {
  print("converting sentence ${sentence}");
  int ret = 0;
  for(int s in sentence.codeUnits) {
    print ("code unit ${new String.fromCharCode(s)}");
    ret += s;
  }
  return ret;
}


import 'dart:html';
import "random.dart";
import 'dart:async';

Element output;
TextAreaElement textAreaElement;

List<String> fontList = <String>["Times New Roman","Lucida Console","Courier New","Verdana","Arial","Strife","Georgia","Comic Sans MS","Impact","Trebuchet MS","Tahoma","Lucida Sans Unicode"];
int count = 0;
int maxCount = 113;
void main() {
  output = querySelector('#output');
  mainLoop();
}

Future<Null> mainLoop() async {
  Random rand = new Random();
  await makeImage(output, randomDennisFact(), rand.pickFrom(fontList));
  count ++;
  if(count < maxCount)     new Timer(new Duration(milliseconds: 100), () => mainLoop());
}



void dennis() {
  String sentence = textAreaElement.value;
  Element div = new DivElement();
  div.text = "${randomDennisFact()}";
  output.append(div);
}

String randomDennisFact() {
  Random rand = new Random();
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

//TODO take in a font (random), make text as big as it can be for height
Future<Null> makeImage(Element div, String s, String font) async {
  int height = 333;
  int width = 130;
  CanvasElement canvas = new CanvasElement(width: width, height: height);
  Random rand = new Random();
  canvas.context2D.setFillColorRgb(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
  canvas.context2D.fillRect(0, 0, width, height);
  canvas.context2D.setFillColorRgb(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
  int fontsize = 28;
  canvas.context2D.font = "${fontsize}px $font";

  int buffer = 100;
  wrap_text(canvas.context2D, s, 10, 30, fontsize, width-buffer, "left");
  output.append(canvas);

}





 int simulateWrapTextToGetFontSize(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, int maxHeight) {
    List<String> words = text.split(' ');
    List<String> lines = <String>[];
    int sliceFrom = 0;
    for (int i = 0; i < words.length; i++) {
    String chunk = words.sublist(sliceFrom, i).join(' ');
    bool last = i == words.length - 1;
    bool bigger = ctx
        .measureText(chunk)
        .width > maxWidth;
    if (bigger) {
    lines.add(words.sublist(sliceFrom, i).join(' '));
    sliceFrom = i;
    }
    if (last) {
    lines.add(words.sublist(sliceFrom, words.length).join(' '));
    sliceFrom = i;
    }
    }
    //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
    return lines.length;

}


//http://stackoverflow.com/questions/5026961/html5-canvas-ctx-filltext-wont-do-line-breaks
 int wrap_text(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, String textAlign) {
    if (textAlign == null) textAlign = 'center';
    ctx.textAlign = textAlign;
    List<String> words = text.split(' ');
    List<String> lines = <String>[];
    int sliceFrom = 0;
    for (int i = 0; i < words.length; i++) {
    String chunk = words.sublist(sliceFrom, i).join(' ');
    bool last = i == words.length - 1;
    bool bigger = ctx
        .measureText(chunk)
        .width > maxWidth;
    if (bigger) {
    lines.add(words.sublist(sliceFrom, i).join(' '));
    sliceFrom = i;
    }
    if (last) {
    lines.add(words.sublist(sliceFrom, words.length).join(' '));
    sliceFrom = i;
    }
    }
    num offsetY = 0.0;
    num offsetX = 0;
    if (textAlign == 'center') offsetX = maxWidth ~/ 2;
    for (int i = 0; i < lines.length; i++) {
    ctx.fillText(lines[i], x + offsetX, y + offsetY);
    offsetY = offsetY + lineHeight;
    }
    //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
    return lines.length;
}





class Size2D {
  int width;
  int height;

  Size2D(int this.width, int this.height);

}
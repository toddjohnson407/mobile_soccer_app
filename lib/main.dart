import 'package:flutter/material.dart';

void main() => runApp(SoccerApp ());

var userInputs = [];
var playerNames = [];

class SoccerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer Substitutions',
      home: InputFields(),
      routes: <String, WidgetBuilder> {
//        '/playerNames': (BuildContext context) => MyPage(title: 'Player Names')
      }
    );
  }
}

// creates new state containing game substitution results
class SubstitutionResults extends StatefulWidget {
  @override
  SubstitutionResultsState createState() => new SubstitutionResultsState();
}

// creates time based substitution widgets
class SubstitutionResultsState extends State<SubstitutionResults> {
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("results")
      ),
    );
  }
}

// create player names state from user input
class PlayerNames extends StatefulWidget {
  @override
  PlayerNamesState createState() => new PlayerNamesState();
}

class PlayerNamesState extends State<PlayerNames> {
  @override
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void submit() {
    playerNames = [];
    _formKey.currentState.save();
    print(playerNames);
  }

  Widget build(BuildContext context) {
    var playerAmount = int.parse(userInputs[0]);
    var playerWidgets = new List<Widget>();

    for (var i = 0; i < playerAmount; i++) {
      playerWidgets.add(new TextFormField(
        maxLength: 3,
        maxLines: 1,
        decoration: new InputDecoration(
          counterText: '',
          labelText: "Player ${i+1}",
        ),
        onSaved: (String value) {
          playerNames.add(value);
        }),
      );
    }

    playerWidgets.add(new Container(
        margin: EdgeInsets.only(top: 30.0),
        child:
        new MaterialButton(
          child: new Text(
              'Submit',
              style: TextStyle(color: Colors.white)),
          color: Colors.blue,
          onPressed: () {
            this.submit();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubstitutionResults())
            );
          },
        )
    )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Player Names")
      ),
      body: new Container(
        margin: new EdgeInsets.only(top: 15.0),
        padding: new EdgeInsets.all(50.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children:
              playerWidgets
          ),
        ),
      ),
    );
  }
}

// create input field state
class InputFields extends StatefulWidget {
  @override
  InputFieldsState createState() => new InputFieldsState();
}

// creates field boxes
class InputFieldsState extends State<InputFields> {
  @override
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void submit() {
    userInputs = [];
    _formKey.currentState.save();
    print(userInputs);
  }

  void _pushSaved() {

  }

  Widget build(BuildContext context) {
    var fieldList = { "playerAmount": "Total Amount of Players: ", "gameTime": "Total Time of Game: ", "playersInAmount": "Amount of Players in at a Time: ", "substitutionIncrement": "How Often Substitution Should Occur: " };
    var fieldTitles = fieldList.values;
    var fieldWidgets = new List<Widget>();

    // create input fields
    for (var title in fieldTitles) {
        fieldWidgets.add(new TextFormField(
          maxLength: 3,
          maxLines: 1,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            counterText: '',
            labelText: title,
          ),
          onSaved: (String value) {
            userInputs.add(value);
          },
        )
      );
    }

    // create submit button
    fieldWidgets.add(new Container(
        margin: EdgeInsets.only(top: 30.0),
        child:
        new MaterialButton(
          child: new Text(
              'Submit',
              style: TextStyle(color: Colors.white)),
          color: Colors.blue,
          onPressed: () {
            this.submit();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayerNames())
            );
          },
        )
      )
    );

    return Scaffold (
      appBar: AppBar (
        title: Text('Soccer Substitutions'),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ]
      ),
      body: new Container(
        padding: new EdgeInsets.all(50.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children:
              fieldWidgets,
          )
        ),
      )
    );
  }
}
import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayValue = "";
  String calculationValue ="";
  bool isReplace = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 150,),
             Text(calculationValue, style: TextStyle(color: Colors.white, fontSize: 20) ,),
            const SizedBox(height: 30,),
            Text(displayValue, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    calculaterButton(buttonName: "mc"),
                    calculaterButton(buttonName: "C"),
                    calculaterButton(buttonName: "7"),
                    calculaterButton(buttonName: "4"),
                    calculaterButton(buttonName: "1"),
                    calculaterButton(buttonName: "%"),
                  ],
                ),
                Column(
                  children: [
                    calculaterButton(buttonName: "m+"),
                    calculaterButton(buttonName: "X"),
                    calculaterButton(buttonName: "8"),
                    calculaterButton(buttonName: "5"),
                    calculaterButton(buttonName: "2"),
                    calculaterButton(buttonName: "0"),
                  ],
                ),
                Column(
                  children: [
                    calculaterButton(buttonName: "m-"),
                    calculaterButton(buttonName: "/", isOperaterButton: true),
                    calculaterButton(buttonName: "9"),
                    calculaterButton(buttonName: "6"),
                    calculaterButton(buttonName: "3"),
                    calculaterButton(buttonName: "."),
                  ],
                ),
                Column(
                  children: [
                    calculaterButton(buttonName: "mr"),
                    calculaterButton(buttonName: "X", isOperaterButton: true),
                    calculaterButton(buttonName: "-", isOperaterButton: true),
                    calculaterButton(buttonName: "+", isOperaterButton: true),
                    calculaterButton(buttonName: "=", isEqualButton: true, isOperaterButton: true),
                    
                  ],
                )
              ],
            )
          ],
        ),
      ) 
    );
  }
  void checkLogic({required String buttonName}){
    setState(() {
      if(buttonName == "C"){
        setState(() {
          displayValue = "";
          calculationValue = "";
          isReplace = false;
        });
      } else if (buttonName == "="){
        if( calculationValue.endsWith("+")||
            calculationValue.endsWith("-")||
            calculationValue.endsWith("*")||
            calculationValue.endsWith("/")){

              String operaterValue = calculationValue[calculationValue.length-1];
             num firstValue =num.parse(calculationValue.substring(0,calculationValue.length-1));
              num secondValue = num.parse(displayValue);
              num? result;
              if(operaterValue == "+"){ 
                result = firstValue + secondValue;
                displayValue = result.toString();
                calculationValue = "$firstValue $operaterValue $secondValue = ";
              }
              else if(operaterValue == "-"){
                result = firstValue - secondValue;
                displayValue = result.toString();
                calculationValue = "$firstValue $operaterValue $secondValue = ";
              }
              else if(operaterValue == "*"){
                result = firstValue * secondValue;
                displayValue = result.toString();
                calculationValue = "$firstValue $operaterValue $secondValue = ";
              }
              else if(operaterValue == "/"){
                result = firstValue / secondValue;
                displayValue = result.toString();
                calculationValue = "$firstValue $operaterValue $secondValue = ";
              }
        }
      }
      
      else if(buttonName == "+"|| buttonName == "-"|| buttonName == "/"|| buttonName == "X"){
          setState(() {
            if(displayValue != ""){
              calculationValue = displayValue + buttonName;
            }else if(calculationValue.isNotEmpty ){
              String operaterValue = calculationValue[calculationValue.length-1];
             num firstValue =num.parse(calculationValue.substring(0,calculationValue.length-1));
              num secondValue = num.parse(displayValue);
              num? result;
              if(operaterValue == "+"){ 
                result = firstValue + secondValue;
                displayValue = result.toString();
                calculationValue = "$result $buttonName";
              }
              else if(operaterValue == "-"){
                result = firstValue - secondValue;
                displayValue = result.toString();
                calculationValue = "$result $buttonName";
              }
              else if(operaterValue == "*"){
                result = firstValue * secondValue;
                displayValue = result.toString();
                calculationValue = "$result $buttonName";              
                }
              else if(operaterValue == "/"){
                result = firstValue / secondValue;
                displayValue = result.toString();
                calculationValue = "$result $buttonName";              
                }
            }
          });
      } else if(int.tryParse(buttonName) != null){
        String? lastCharacterOfCalculationVal;
          if(calculationValue.isNotEmpty){
            lastCharacterOfCalculationVal = calculationValue[calculationValue.length-1];
            if( lastCharacterOfCalculationVal == "+" ||
                lastCharacterOfCalculationVal == "-" ||
                lastCharacterOfCalculationVal == "*" ||
                lastCharacterOfCalculationVal == "/"){
                  if(isReplace){
                    displayValue = displayValue + buttonName;
                  } else{
                    displayValue = buttonName;
                    isReplace = true;
                  }
                }
                else if(calculationValue.endsWith("=")){
                  displayValue = "";
                  displayValue = calculationValue;
                  isReplace = false;
                }
          } else{
            displayValue = displayValue + buttonName;
          }
        }
    });
  }

  Padding calculaterButton({required String buttonName, bool isEqualButton = false , bool isOperaterButton = false}) {
    return Padding(
                    padding: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: (){
                        checkLogic(buttonName: buttonName);
                      },
                      child: Container(
                        child: Center(
                          child: Text( buttonName, 
                          style: TextStyle(
                            fontSize: 20, 
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                            )
                          )
                        ),
                        width: 70,
                        height: isEqualButton ? 148: 70,
                        decoration: BoxDecoration(
                          color: isOperaterButton?  const Color.fromARGB(255, 179, 164, 26):const Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.circular(10)
                        ),
          ),
        ),
    );
  }
}
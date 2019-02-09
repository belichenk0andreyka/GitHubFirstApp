// import 'package:flutter/material.dart';

// class PassTextField extends StatefulWidget {
//   _PassTextFieldState createState() => _PassTextFieldState();
// }

// class _PassTextFieldState extends State<PassTextField> {
//   bool _obscureText = true;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(25, 0, 50, 10),
//       child: TextFormField(
//         validator: (input) {
//                 if(input.isEmpty){
//                   return 'Provide an email';
//                 }
//               },
//         obscureText: _obscureText,
//         style: TextStyle(
//           color: Color(0xFF01579B),
//           fontSize: 18.0,
//         ),
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           onSaved: (input) => _email = input,
//           hintText: 'Enter your password',
//           labelText: "Password",
//           icon: Padding(
//             padding: EdgeInsets.only(top: 15.0),
//             child: Icon(Icons.lock),
//           ),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//             child: Icon(
//               _obscureText ? Icons.visibility : Icons.visibility_off,
//               semanticLabel: _obscureText ? 'show password' : 'hide password',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

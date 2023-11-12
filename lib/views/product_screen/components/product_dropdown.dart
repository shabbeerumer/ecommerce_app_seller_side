// import '../../../const/const.dart';
// import '../../../widgets/texts.dart';
//
// Widget productdropdown(hint, List<String> list, dropvalue, controller) {
//   return Container(
//     color: white,
//     child: DropdownButton(
//         hint: normaltext(text: hint, color: Colors.black),
//         value: dropvalue == '' ? null : dropvalue,
//         isExpanded: true,
//         items: list.map((e) {
//           return DropdownMenuItem(
//             child: normaltext(text: e, color: Colors.black),
//             value: e,
//           );
//         }).toList(),
//         onChanged: (value) {
//           if (hint == 'category') {
//             controller.subcategotyvalue = '';
//             controller.populatesubcategory(value.toString());
//           }
//           dropvalue = value.toString();
//         }),
//   );
// }

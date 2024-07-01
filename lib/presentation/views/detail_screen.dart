// import 'package:flutter/material.dart';

// class DetailScreen extends StatelessWidget {
//   final dynamic item;
//   const DetailScreen({super.key, this.item});

//   @override
//   Widget build(BuildContext context) {
//     var style = const TextStyle(fontSize: 18, color: Colors.white);
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 16, 25, 41),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 16, 25, 41),
//         foregroundColor: Colors.white,
//         title: Text(item['Name']),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   item['ImgUrlPath'] != null
//                       ? Hero(
//                           tag: 'image${item['Id']}',
//                           child: Image.network(
//                             "https://coinoneglobal.in/crm/${item['ImgUrlPath']}",
                            // width: double.infinity,
                            // height: MediaQuery.of(context).size.height / 2,
                            // fit: BoxFit.cover,
//                           ),
//                         )
//                       : const Placeholder(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       item['Name'],
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'ID: ${item['Id']}',
//               style: style,
//             ),
//             Text(
//               'Code: ${item['Code']}',
//               style: style,
//             ),
//             Text(
//               'Order Index: ${item['OrderIndex']}',
//               style: style,
//             ),
//             Text(
//               'Parent: ${item['Parent']}',
//               style: style,
//             ),
//             Text(
//               'Remarks: ${item['Remarks']}',
//               style: style,
//             ),
//             Text(
//               'Update Date: ${item['UpdateDate']}',
//               style: style,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:coinone_sample_app/domain/use_cases/sign_in_use_case.dart';
import 'package:coinone_sample_app/presentation/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String imgId = ModalRoute.of(context)!.settings.arguments as String;

    var style = const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 25, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 25, 41),
        foregroundColor: Colors.white,
        title: const Text("Image Detail"),
      ),
      body: BlocProvider(
        create: (context) => ProductBloc(context.read<SignInUseCase>())
          ..add(FetchImageDetailsRequested(imgId)),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state.dataList.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            List<dynamic> imageDetails = state.dataList;

            // String imgUrlPath = imageDetails[0]['ImgUrlPath'];
            // String fullImageUrl =
            //     'https://coinoneglobal.in/crm/$imgUrlPath'; // Adjust URL construction based on your API response

            return  ListView.builder(
              itemCount: imageDetails.length,
              itemBuilder: (context,index) {
                String imgUrlPath = imageDetails[index]['ImgUrlPath'];
                String fullImageUrl =
                    'https://coinoneglobal.in/crm/$imgUrlPath';
                return Center(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Hero(
                            tag: 'image${imageDetails[index]['Id']}',
                            child: Image.network(fullImageUrl,    width: double.infinity,
                                height: MediaQuery.of(context).size.height / 2,
                                fit: BoxFit.cover,),
                          ),
                          const SizedBox(height: 16),
                          Text(imageDetails[index]['Name'], style: style),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          },
        ),
      ),
    );
  }
}

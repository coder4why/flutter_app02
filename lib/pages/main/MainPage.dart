// ignore: file_names
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final List<Map<String, String>> dataModels = [
    {
      'title': 'Apple1',
      'subTitle': 'Macbook Product1',
      'imageUrl':
          'https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg'
    },
    {
      'title': 'Apple2',
      'subTitle': 'Macbook Product2',
      'imageUrl':
          'https://tva1.sinaimg.cn/large/006y8mN6gy1g72imm9u5zj30u00k0adf.jpg'
    },
    {
      'title': 'Apple3',
      'subTitle': 'Macbook Product3',
      'imageUrl':
          'https://tva1.sinaimg.cn/large/006y8mN6gy1g72imqlouhj30u00k00v0.jpg'
    },
  ];

  final List<Widget> proLists = [];
  List<Widget> renderProducts() {
    for (var item in dataModels) {
      proLists.add(ProductWidget(
          item['title'] ?? '', item['subTitle'] ?? '', item['imageUrl'] ?? ''));
    }
    return proLists;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 2),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: renderProducts(),
        )
      ],
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  const ProductWidget(this.title, this.subTitle, this.imageUrl, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 223, 220, 220))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 44,
              height: 230,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            )
          ],
        ));
  }
}

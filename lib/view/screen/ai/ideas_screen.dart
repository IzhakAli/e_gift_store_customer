import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Make sure to import the get package

import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/openai_model.dart';

class IdeasScreen extends StatelessWidget {
  final GptData gptReponseData;

  IdeasScreen({super.key, required this.gptReponseData});

  @override
  Widget build(BuildContext context) {
    List<Widget> choiceCards = gptReponseData.choices
        .map((choice) => Card(
              surfaceTintColor: AppColor.primary,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  choice.text,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium, // Choose a suitable text style
                  textAlign: TextAlign.start,
                ),
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("eGift Ideas"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(AppRoute.homePage);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // Use ListView to allow scrolling through the cards
          children: [
            Text(
              "The AI has spoken 🥳",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...choiceCards, // Insert all the choice cards here
          ],
        ),
      ),
    );
  }
}

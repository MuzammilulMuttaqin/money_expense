import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildExpenseShimmer() {
  return Column(
    children: List.generate(3, (index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 100,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 10,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      );
    }),
  );
}
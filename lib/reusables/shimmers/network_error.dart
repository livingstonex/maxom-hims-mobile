import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class NetworkErrorShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   var cont_width =  MediaQuery.of(context).size.width * 0.65;

    return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Center(
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.asset('images/black_signal_tower.png'),
                    ),
                ),
        );
  }
}
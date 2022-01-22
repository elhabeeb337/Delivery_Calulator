import 'dart:math';
import 'dart:io';

//calculate delivery fee total

  double feeCalc(
    double cartValue, double distance, int itemsNum, DateTime transactionTime) {
  double totalDeliveryFee = 0.0;
  const double kMaxDeliveryFee = 15;


  //Adding surcharge when cartValue < 10
  double surchargeCartValue(double cartValue) {
    const double kMinDeliveryFee = 10;

    if (cartValue < kMinDeliveryFee) {
      return kMinDeliveryFee - cartValue;
    }
    return 0.0;
  }

  // Distance fee calculation
  double distanceFee(double distance) {
    const double kMinDistance = 1000;
    const double kMinDistanceFee = 2;
    const double kAddDistance = 500;

  if (distance < kMinDistance) {
    return kMinDistanceFee;
  } 
  return kMinDistanceFee + ((distance - kMinDistance) / kAddDistance).ceil();
  }

  //Adding Surcharge when itemNum > 4
  double surchargeOnItemsNum(int itemsNum) {
    double itemSurcharge = 0.0;
    const double kItemsurcharge = 0.50;

    if (itemsNum > 4) {
      itemSurcharge = ((itemsNum - 4) * kItemsurcharge);
      
      return itemSurcharge;
  }
  return itemSurcharge;
}

//Friday rush hour
bool isRushHr(DateTime transactionTime) {
  bool isFridayRush = false;

  if ((transactionTime.weekday == DateTime.friday) &&
      (15 <= transactionTime.hour) &&
      (transactionTime.hour <= 19)) {
    isFridayRush = true;
  }

  return isFridayRush;
}
//First senario (no cart value or item to deliver)
  if (cartValue == 0.0 && itemsNum == 0.0) {
    return totalDeliveryFee;
  }
  //Second senario (with cartValue < 100)
  if (cartValue < 100) {
    totalDeliveryFee = surchargeCartValue(cartValue) +
        distanceFee(distance) +
        surchargeOnItemsNum(itemsNum);

    //Third senario (Friday rush hour)
    bool rushHr = isRushHr(transactionTime);
    if (rushHr) {
      totalDeliveryFee = totalDeliveryFee * 1.1;
    }
  }
  return min(totalDeliveryFee, kMaxDeliveryFee);
    }

//import 'delivery_app.dart';

// The variables used to calculate the Fee.
double cartValue = 0.0, distance = 0.0;
int itemsNum = 0;

void main() {

   print("Enter cart value");
  cartValue = double.parse(stdin.readLineSync()!);

  print("Enter the amount of items");
  itemsNum = int.parse(stdin.readLineSync()!);

  print("Enter distance in meters");
  distance = double.parse(stdin.readLineSync()!);

  print("Enter delivery date and time in the format YYYYMMDD HHMMSS");
  DateTime transactionTime = DateTime.parse(stdin.readLineSync()!);

  // to calculate delivery fee
  double totalDeliveryFee = feeCalc(cartValue, distance, itemsNum, transactionTime);
  print("Delivery totalDeliveryFee is $totalDeliveryFee");
}





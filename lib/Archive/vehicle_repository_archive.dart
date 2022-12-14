import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/models/vehicle_model.dart';


abstract class BaseVehicleRepository {

  Future<List<Vehicle>> retrieveVehicles({required String userId});
  //Future<List<Vehicle>> retrieveBookedVehicles({required String userId});
  Future<String> createVehicle({required String userId, required Vehicle vehicle});
  Future<String> addVehicleToABookingInAllBookingsDatabase({required String bookingId, required Vehicle vehicle});
  Future<String> addVehicleToABookingInUsersBookingsCollection({required String bookingID, required Vehicle vehicle, required String userId});
  Future<void> updateVehicle({required String userId, required Vehicle vehicle});
  Future<void> deleteVehicle({required String userId, required String vehicleId});
  //Future<void> unbookAllVehicles({required String userId});


}

final vehicleRepositoryProvider =
Provider<VehicleRepository>((ref) => VehicleRepository(ref.read));

class VehicleRepository implements BaseVehicleRepository{
  final Reader _read;
  const VehicleRepository(this._read);
  
  
 

  @override
  Future<String> createVehicle ({required String userId, required Vehicle vehicle}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userVehicleRef(userId).add(vehicle.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> addVehicleToABookingInAllBookingsDatabase({required String bookingId, required Vehicle vehicle}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider).allBookingsDatabaseVehiclesRef(
          bookingId).add(vehicle.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> addVehicleToABookingInUsersBookingsCollection({required String bookingID, required Vehicle vehicle, required String userId}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider).userBookingRefToAddVehicles(userId, bookingID).add(vehicle.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
  @override
  Future<void> updateVehicle({required String userId, required Vehicle vehicle}) async{
    try {
      await _read(firebaseFirestoreProvider)
          .userVehicleRef(userId)
          .doc(vehicle.id)
          .update(vehicle.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  // @override
  // Future<void> unbookAllVehicles({required String userId}) async{
  //
  //   try{
  //     await _read(firebaseFirestoreProvider).userVehicleRef(userId)
  //
  //   }on FirebaseException catch (e) {
  //     throw CustomException(message: e.message);
  //   }
  // }
  @override
  Future<void> deleteVehicle({required String userId, required String vehicleId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userVehicleRef(userId)
          .doc(vehicleId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Vehicle>> retrieveVehicles({required String userId}) async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .userVehicleRef(userId)
          .get();
      return snap.docs.map((doc) => Vehicle.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  // @override
  // Future<List<Vehicle>> retrieveBookedVehicles({required String userId}) async{
  //   try {
  //     final snap = await _read(firebaseFirestoreProvider)
  //         .userVehicleRef(userId).where("isBooked",isEqualTo: true)//where("isBooked", "==" , true)
  //         .get();
  //     return snap.docs.map((doc) => Vehicle.fromDocument(doc)).toList();
  //   } on FirebaseException catch (e) {
  //     throw CustomException(message: e.message);
  //   }
  // }

 }





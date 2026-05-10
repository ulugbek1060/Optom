import 'package:flutter/material.dart';

class Product {
  final String id;
  final String model;
  final String region;
  final String storage;
  final String color;
  final double cost;
  final Condition condition; // New/Used
  final Status status; // Working/Defective
  final String notes;
  final SellingStatus sellingStatus; // Available/Sold/Reserved
  final String? availableCount;
  final String? imei;
  final String? barcode; // barcode not required
  final SimSlotType simSlotType; // Single SIM/Dual SIM/eSIM
  final DateTime createdAt;

  Product({
    required this.id,
    required this.model,
    required this.region,
    required this.storage,
    required this.color,
    required this.cost,
    required this.condition,
    required this.status,
    required this.notes,
    required this.sellingStatus,
    this.availableCount,
    this.imei,
    this.barcode,
    required this.simSlotType,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Copy with new values
  Product copyWith({
    String? id,
    String? model,
    String? region,
    String? storage,
    String? color,
    double? cost,
    Condition? condition,
    Status? status,
    String? notes,
    SellingStatus? sellingStatus,
    String? imei,
    String? availableCount,
    String? barcode,
    SimSlotType? simSlotType,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      model: model ?? this.model,
      region: region ?? this.region,
      storage: storage ?? this.storage,
      color: color ?? this.color,
      cost: cost ?? this.cost,
      condition: condition ?? this.condition,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      sellingStatus: sellingStatus ?? this.sellingStatus,
      availableCount: availableCount ?? this.availableCount,
      imei: imei ?? this.imei,
      barcode: imei ?? this.barcode,
      simSlotType: simSlotType ?? this.simSlotType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Get formatted selling price (you can add selling price later)
  double? sellingPrice;
}

// Condition enum: New/Used
enum Condition {
  NEW,
  used;

  String get displayName {
    switch (this) {
      case Condition.NEW:
        return 'New';
      case Condition.used:
        return 'Used';
    }
  }

  static Condition fromString(String value) {
    return value.toLowerCase() == 'new' ? Condition.NEW : Condition.used;
  }
}

// Status enum: Working/Defective
enum Status {
  working,
  defective;

  String get displayName {
    switch (this) {
      case Status.working:
        return 'Working';
      case Status.defective:
        return 'Defective';
    }
  }

  static Status fromString(String value) {
    if (value.toLowerCase() == 'working') return Status.working;
    if (value.toLowerCase() == 'defective') return Status.defective;
    return Status.working;
  }
}

// Selling Status enum: Available/Sold/Reserved/Sold but not paid
enum SellingStatus {
  available,
  sold,
  reserved,
  soldButNotPaid;

  String get displayName {
    switch (this) {
      case SellingStatus.available:
        return 'Available';
      case SellingStatus.sold:
        return 'Sold';
      case SellingStatus.reserved:
        return 'Reserved';
      case SellingStatus.soldButNotPaid:
        return 'Sold but not paid';
    }
  }

  Color get color {
    switch (this) {
      case SellingStatus.available:
        return Colors.green;
      case SellingStatus.sold:
      case SellingStatus.soldButNotPaid:
        return Colors.red;
      case SellingStatus.reserved:
        return Colors.orange;
    }
  }

  static SellingStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'available':
        return SellingStatus.available;
      case 'sold':
        return SellingStatus.sold;
      case 'reserved':
        return SellingStatus.reserved;
      case 'sold but not paid':
        return SellingStatus.soldButNotPaid;
      default:
        return SellingStatus.available;
    }
  }
}

// Extended SIM Slot Type enum
enum SimSlotType {
  singleSim, // 1 Physical slot only
  dualSim, // 2 Physical slots (China/HK/Macao models)
  eSim, // eSIM only (US iPhone 14+)
  simPlusEsim, // 1 Physical + 1 eSIM (Standard International)
  dualEsim, // 2 Active eSIMs (iPhone 13+)
  wifi; // iPads/Non-cellular

  String get displayName {
    switch (this) {
      case SimSlotType.singleSim:
        return 'Single SIM';
      case SimSlotType.dualSim:
        return 'Dual Physical SIM';
      case SimSlotType.eSim:
        return 'eSIM Only';
      case SimSlotType.simPlusEsim:
        return 'SIM + eSIM';
      case SimSlotType.dualEsim:
        return 'Dual eSIM';
      case SimSlotType.wifi:
        return 'WiFi Only';
    }
  }

  String get shortName {
    switch (this) {
      case SimSlotType.singleSim:
        return '1 SIM';
      case SimSlotType.dualSim:
        return '2 SIM';
      case SimSlotType.eSim:
        return 'eSIM';
      case SimSlotType.simPlusEsim:
        return 'SIM+eSIM';
      case SimSlotType.dualEsim:
        return '2 eSIM';
      case SimSlotType.wifi:
        return 'WiFi';
    }
  }

  static SimSlotType fromString(String value) {
    switch (value.toLowerCase().replaceAll(' ', '')) {
      case 'singlesim':
      case 'single':
        return SimSlotType.singleSim;
      case 'dualsim':
      case 'dual':
      case 'dualphysical':
        return SimSlotType.dualSim;
      case 'esimonly':
      case 'esim':
        return SimSlotType.eSim;
      case 'simplusesim':
      case 'hybrid':
        return SimSlotType.simPlusEsim;
      case 'dualesim':
        return SimSlotType.dualEsim;
      case 'wifi':
      case 'noncellular':
        return SimSlotType.wifi;
      default:
        return SimSlotType.singleSim;
    }
  }
}

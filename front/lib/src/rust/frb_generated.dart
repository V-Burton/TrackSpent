// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.2.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'api/simple.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'lib.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {}

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.2.0';

  @override
  int get rustContentHash => 1089182091;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'rust_lib_front',
    ioDirectory: 'rust/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  double crateApiSimpleSpentAutoAccessorGetAmount({required Spent that});

  NaiveDate crateApiSimpleSpentAutoAccessorGetDate({required Spent that});

  String crateApiSimpleSpentAutoAccessorGetReason({required Spent that});

  void crateApiSimpleSpentAutoAccessorSetAmount(
      {required Spent that, required double amount});

  void crateApiSimpleSpentAutoAccessorSetDate(
      {required Spent that, required NaiveDate date});

  void crateApiSimpleSpentAutoAccessorSetReason(
      {required Spent that, required String reason});

  BigInt crateApiSimpleDebugResultLength();

  Future<String> crateApiSimpleGetFormattedDate({required NaiveDate date});

  Future<Spent?> crateApiSimpleGetSpent();

  String crateApiSimpleGetValue({required BigInt indice});

  void crateApiSimpleInitApp();

  Future<void> crateApiSimpleInitializeResultWithDummyData();

  Future<void> crateApiSimpleIntialize();

  void crateApiSimpleLoadTransactionsFromFile();

  Future<void> crateApiSimpleParseAndUseDate({required String dateStr});

  Future<void> crateApiSimplePushTransactionToResult(
      {required TransactionsData data});

  String crateApiSimpleTest();

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_NaiveDate;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_NaiveDate;

  CrossPlatformFinalizerArg get rust_arc_decrement_strong_count_NaiveDatePtr;

  RustArcIncrementStrongCountFnType get rust_arc_increment_strong_count_Spent;

  RustArcDecrementStrongCountFnType get rust_arc_decrement_strong_count_Spent;

  CrossPlatformFinalizerArg get rust_arc_decrement_strong_count_SpentPtr;

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_TransactionsData;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_TransactionsData;

  CrossPlatformFinalizerArg
      get rust_arc_decrement_strong_count_TransactionsDataPtr;
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  double crateApiSimpleSpentAutoAccessorGetAmount({required Spent that}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            that, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 1)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_f_64,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleSpentAutoAccessorGetAmountConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleSpentAutoAccessorGetAmountConstMeta =>
      const TaskConstMeta(
        debugName: "Spent_auto_accessor_get_amount",
        argNames: ["that"],
      );

  @override
  NaiveDate crateApiSimpleSpentAutoAccessorGetDate({required Spent that}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            that, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 2)!;
      },
      codec: SseCodec(
        decodeSuccessData:
            sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleSpentAutoAccessorGetDateConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleSpentAutoAccessorGetDateConstMeta =>
      const TaskConstMeta(
        debugName: "Spent_auto_accessor_get_date",
        argNames: ["that"],
      );

  @override
  String crateApiSimpleSpentAutoAccessorGetReason({required Spent that}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            that, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 3)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleSpentAutoAccessorGetReasonConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleSpentAutoAccessorGetReasonConstMeta =>
      const TaskConstMeta(
        debugName: "Spent_auto_accessor_get_reason",
        argNames: ["that"],
      );

  @override
  void crateApiSimpleSpentAutoAccessorSetAmount(
      {required Spent that, required double amount}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            that, serializer);
        sse_encode_f_64(amount, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 4)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleSpentAutoAccessorSetAmountConstMeta,
      argValues: [that, amount],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleSpentAutoAccessorSetAmountConstMeta =>
      const TaskConstMeta(
        debugName: "Spent_auto_accessor_set_amount",
        argNames: ["that", "amount"],
      );

  @override
  void crateApiSimpleSpentAutoAccessorSetDate(
      {required Spent that, required NaiveDate date}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            that, serializer);
        sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
            date, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 5)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleSpentAutoAccessorSetDateConstMeta,
      argValues: [that, date],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleSpentAutoAccessorSetDateConstMeta =>
      const TaskConstMeta(
        debugName: "Spent_auto_accessor_set_date",
        argNames: ["that", "date"],
      );

  @override
  void crateApiSimpleSpentAutoAccessorSetReason(
      {required Spent that, required String reason}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            that, serializer);
        sse_encode_String(reason, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 6)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleSpentAutoAccessorSetReasonConstMeta,
      argValues: [that, reason],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleSpentAutoAccessorSetReasonConstMeta =>
      const TaskConstMeta(
        debugName: "Spent_auto_accessor_set_reason",
        argNames: ["that", "reason"],
      );

  @override
  BigInt crateApiSimpleDebugResultLength() {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 7)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_usize,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleDebugResultLengthConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleDebugResultLengthConstMeta =>
      const TaskConstMeta(
        debugName: "debug_result_length",
        argNames: [],
      );

  @override
  Future<String> crateApiSimpleGetFormattedDate({required NaiveDate date}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
            date, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 8, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleGetFormattedDateConstMeta,
      argValues: [date],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleGetFormattedDateConstMeta =>
      const TaskConstMeta(
        debugName: "get_formatted_date",
        argNames: ["date"],
      );

  @override
  Future<Spent?> crateApiSimpleGetSpent() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 9, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData:
            sse_decode_opt_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiSimpleGetSpentConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleGetSpentConstMeta => const TaskConstMeta(
        debugName: "get_spent",
        argNames: [],
      );

  @override
  String crateApiSimpleGetValue({required BigInt indice}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_usize(indice, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 10)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleGetValueConstMeta,
      argValues: [indice],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleGetValueConstMeta => const TaskConstMeta(
        debugName: "get_value",
        argNames: ["indice"],
      );

  @override
  void crateApiSimpleInitApp() {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 11)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleInitAppConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleInitAppConstMeta => const TaskConstMeta(
        debugName: "init_app",
        argNames: [],
      );

  @override
  Future<void> crateApiSimpleInitializeResultWithDummyData() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 12, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleInitializeResultWithDummyDataConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleInitializeResultWithDummyDataConstMeta =>
      const TaskConstMeta(
        debugName: "initialize_result_with_dummy_data",
        argNames: [],
      );

  @override
  Future<void> crateApiSimpleIntialize() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 13, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleIntializeConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleIntializeConstMeta => const TaskConstMeta(
        debugName: "intialize",
        argNames: [],
      );

  @override
  void crateApiSimpleLoadTransactionsFromFile() {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 14)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiSimpleLoadTransactionsFromFileConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleLoadTransactionsFromFileConstMeta =>
      const TaskConstMeta(
        debugName: "load_transactions_from_file",
        argNames: [],
      );

  @override
  Future<void> crateApiSimpleParseAndUseDate({required String dateStr}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(dateStr, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 15, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiSimpleParseAndUseDateConstMeta,
      argValues: [dateStr],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleParseAndUseDateConstMeta =>
      const TaskConstMeta(
        debugName: "parse_and_use_date",
        argNames: ["dateStr"],
      );

  @override
  Future<void> crateApiSimplePushTransactionToResult(
      {required TransactionsData data}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
            data, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 16, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimplePushTransactionToResultConstMeta,
      argValues: [data],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimplePushTransactionToResultConstMeta =>
      const TaskConstMeta(
        debugName: "push_transaction_to_result",
        argNames: ["data"],
      );

  @override
  String crateApiSimpleTest() {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 17)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleTestConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleTestConstMeta => const TaskConstMeta(
        debugName: "test",
        argNames: [],
      );

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_NaiveDate => wire
          .rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_NaiveDate => wire
          .rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate;

  RustArcIncrementStrongCountFnType get rust_arc_increment_strong_count_Spent =>
      wire.rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent;

  RustArcDecrementStrongCountFnType get rust_arc_decrement_strong_count_Spent =>
      wire.rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent;

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_TransactionsData => wire
          .rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_TransactionsData => wire
          .rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData;

  @protected
  NaiveDate
      dco_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return NaiveDateImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Spent
      dco_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return SpentImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Spent
      dco_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return SpentImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  TransactionsData
      dco_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return TransactionsDataImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Spent
      dco_decode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return SpentImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  NaiveDate
      dco_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return NaiveDateImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Spent
      dco_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return SpentImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  TransactionsData
      dco_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return TransactionsDataImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  Spent
      dco_decode_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
        raw);
  }

  @protected
  double dco_decode_f_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as double;
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  Spent?
      dco_decode_opt_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw == null
        ? null
        : dco_decode_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
            raw);
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  BigInt dco_decode_usize(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeU64(raw);
  }

  @protected
  NaiveDate
      sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return NaiveDateImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Spent
      sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return SpentImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Spent
      sse_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return SpentImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  TransactionsData
      sse_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return TransactionsDataImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Spent
      sse_decode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return SpentImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  NaiveDate
      sse_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return NaiveDateImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Spent
      sse_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return SpentImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  TransactionsData
      sse_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return TransactionsDataImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  Spent
      sse_decode_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
        deserializer));
  }

  @protected
  double sse_decode_f_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getFloat64();
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  Spent?
      sse_decode_opt_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    if (sse_decode_bool(deserializer)) {
      return (sse_decode_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          deserializer));
    } else {
      return null;
    }
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  BigInt sse_decode_usize(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getBigUint64();
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  void
      sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
          NaiveDate self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as NaiveDateImpl).frbInternalSseEncode(move: true), serializer);
  }

  @protected
  void
      sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          Spent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as SpentImpl).frbInternalSseEncode(move: true), serializer);
  }

  @protected
  void
      sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          Spent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as SpentImpl).frbInternalSseEncode(move: false), serializer);
  }

  @protected
  void
      sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
          TransactionsData self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as TransactionsDataImpl).frbInternalSseEncode(move: false),
        serializer);
  }

  @protected
  void
      sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          Spent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as SpentImpl).frbInternalSseEncode(move: false), serializer);
  }

  @protected
  void
      sse_encode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerNaiveDate(
          NaiveDate self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as NaiveDateImpl).frbInternalSseEncode(move: null), serializer);
  }

  @protected
  void
      sse_encode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          Spent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as SpentImpl).frbInternalSseEncode(move: null), serializer);
  }

  @protected
  void
      sse_encode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerTransactionsData(
          TransactionsData self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as TransactionsDataImpl).frbInternalSseEncode(move: null),
        serializer);
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void
      sse_encode_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          Spent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
        self, serializer);
  }

  @protected
  void sse_encode_f_64(double self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putFloat64(self);
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void
      sse_encode_opt_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          Spent? self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    sse_encode_bool(self != null, serializer);
    if (self != null) {
      sse_encode_box_autoadd_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerSpent(
          self, serializer);
    }
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_usize(BigInt self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putBigUint64(self);
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }
}

@sealed
class NaiveDateImpl extends RustOpaque implements NaiveDate {
  // Not to be used by end users
  NaiveDateImpl.frbInternalDcoDecode(List<dynamic> wire)
      : super.frbInternalDcoDecode(wire, _kStaticData);

  // Not to be used by end users
  NaiveDateImpl.frbInternalSseDecode(BigInt ptr, int externalSizeOnNative)
      : super.frbInternalSseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_NaiveDate,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_NaiveDate,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_NaiveDatePtr,
  );
}

@sealed
class SpentImpl extends RustOpaque implements Spent {
  // Not to be used by end users
  SpentImpl.frbInternalDcoDecode(List<dynamic> wire)
      : super.frbInternalDcoDecode(wire, _kStaticData);

  // Not to be used by end users
  SpentImpl.frbInternalSseDecode(BigInt ptr, int externalSizeOnNative)
      : super.frbInternalSseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_Spent,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_Spent,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_SpentPtr,
  );

  double get amount =>
      RustLib.instance.api.crateApiSimpleSpentAutoAccessorGetAmount(
        that: this,
      );

  NaiveDate get date =>
      RustLib.instance.api.crateApiSimpleSpentAutoAccessorGetDate(
        that: this,
      );

  String get reason =>
      RustLib.instance.api.crateApiSimpleSpentAutoAccessorGetReason(
        that: this,
      );

  set amount(double amount) => RustLib.instance.api
      .crateApiSimpleSpentAutoAccessorSetAmount(that: this, amount: amount);

  set date(NaiveDate date) => RustLib.instance.api
      .crateApiSimpleSpentAutoAccessorSetDate(that: this, date: date);

  set reason(String reason) => RustLib.instance.api
      .crateApiSimpleSpentAutoAccessorSetReason(that: this, reason: reason);
}

@sealed
class TransactionsDataImpl extends RustOpaque implements TransactionsData {
  // Not to be used by end users
  TransactionsDataImpl.frbInternalDcoDecode(List<dynamic> wire)
      : super.frbInternalDcoDecode(wire, _kStaticData);

  // Not to be used by end users
  TransactionsDataImpl.frbInternalSseDecode(
      BigInt ptr, int externalSizeOnNative)
      : super.frbInternalSseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_TransactionsData,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_TransactionsData,
    rustArcDecrementStrongCountPtr: RustLib
        .instance.api.rust_arc_decrement_strong_count_TransactionsDataPtr,
  );
}

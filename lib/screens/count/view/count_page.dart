import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/data/database/dbsqlite.dart';
import 'package:ams_count/data/models/default_response.dart';
import 'package:ams_count/models/count/CountScan_output.dart';

import 'package:ams_count/widgets/alert.dart';
import 'package:ams_count/widgets/alert_new.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../blocs/count/count_bloc.dart';

import '../../../config/app_data.dart';
import '../../../models/count/countPlanModel.dart';
import '../../../models/count/responeModel.dart';
import '../../../widgets/custom_range_pointer.dart';

class CountPage extends StatefulWidget {
  const CountPage({super.key});

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  List<CountPlanModel> itemModel = [];
  List<CountPlanModel> _tempitemModel = [];

  ResponseModel itemCheckAll = ResponseModel();
  ResponseModel itemCheck = ResponseModel();
  ResponseModel itemUncheck = ResponseModel();
  FocusNode _searchCodeFocus = FocusNode();
  String? mode;

  TextEditingController _searchController = TextEditingController();
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  @override
  void initState() {
    BlocProvider.of<CountBloc>(context).add(const GetListCountPlanEvent());
    BlocProvider.of<CountBloc>(context).add(const CheckAllTotalEvent());
    BlocProvider.of<CountBloc>(context).add(const CheckTotalEvent());
    BlocProvider.of<CountBloc>(context).add(const CheckUncheckEvent());
    AppData.getMode().then((test) {
      mode = test;
    });

    super.initState();
  }

  Future<void> loadData() async {
    if (await AppData.getMode() == "Online") {
      await ResponseModel().update(
          check: itemCheck.DATA,
          uncheck: itemUncheck.DATA,
          total: itemCheckAll.DATA);
    } else if (await AppData.getMode() == "Offline") {
      var itemSql = await ResponseModel().query();
      if (itemSql.isNotEmpty) {
        itemCheck.DATA = await itemSql[0]['${CheckAllField.CHECK}'];
        itemUncheck.DATA = await itemSql[0]['${CheckAllField.UNCHECK}'];
        itemCheckAll.DATA = await itemSql[0]['${CheckAllField.TOTAL}'];
      }
    }
    setState(() {});
  }

  void _serachItemModel() {
    List<CountPlanModel> searchResults = _tempitemModel
        .where((element) => element.PLAN_CODE == _searchController.text)
        .toList();
    if (searchResults.isNotEmpty) {
      itemModel = searchResults;
    } else {
      Alert.show(title: "Plan Invaild", message: "Please Input or Scan Again");
      itemModel = _tempitemModel;
    }
    setState(() {});
  }

  Future<void> _addDataSqlite() async {
    var itemSql = await CountPlanModel().queryAllRows();
    if (itemSql.isNotEmpty) {
      await DbSqlite()
          .deleteAll(context, tableName: '${CountPlanField.TABLE_NAME}');
      for (var item in itemModel) {
        await CountPlanModel().insert(item.toJson());
      }
    } else {
      for (var item in itemModel) {
        await CountPlanModel().insert(item.toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetListCountPlanLoadedState) {
            setState(() {
              itemModel = state.item;
              _tempitemModel = state.item;
            });

            await _addDataSqlite();
          } else if (state is GetListCountPlanErrorState) {
            var itemSql = await CountPlanModel().queryAllRows();
            setState(() {
              itemModel =
                  itemSql.map((item) => CountPlanModel.fromJson(item)).toList();
              _tempitemModel =
                  itemSql.map((item) => CountPlanModel.fromJson(item)).toList();
              ;
            });
          }

          ///CheckAll
          if (state is CheckAllLoadedState) {
            setState(() {
              itemCheckAll = state.item;
            });
            loadData();
          } else if (state is CheckAllErrorState) {
            loadData();
          }
          //Check select
          if (state is CheckTotalLoadingState) {
          } else if (state is CheckTotalLoadedState) {
            setState(() {
              itemCheck = state.item;
            });
            loadData();
          } else if (state is CheckTotalErrorState) {
            loadData();
          }

          //Uncheck
          if (state is CheckUncheckLoadingState) {
          } else if (state is CheckUncheckLoadedState) {
            setState(() {
              itemUncheck = state.item;
            });
            loadData();
          } else if (state is CheckUncheckErrorState) {
            loadData();
          }
        })
      ],
      child: Scaffold(
          backgroundColor: colorPrimary,
          appBar: AppBar(
            elevation: 10,
            centerTitle: true,
            title: const Text(
              "List Count",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                itemUncheck.DATA != null
                                    ? Expanded(
                                        child: CustomRangePoint(
                                          color: Colors.red,
                                          valueRangePointer: itemUncheck.DATA,
                                          allItem: itemUncheck.DATA,
                                          text: "Uncheck",
                                        ),
                                      )
                                    : const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Label(
                                    "Total\n${itemCheckAll.DATA}",
                                    color: colorPrimary,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                itemCheck.DATA != null
                                    ? Expanded(
                                        child: CustomRangePoint(
                                          color: colorActive,
                                          valueRangePointer: itemCheck.DATA,
                                          allItem: itemCheckAll.DATA,
                                          text: "Check",
                                        ),
                                      )
                                    : const CircularProgressIndicator(),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomTextInputField(
                              focusNode: _searchCodeFocus,
                              onChanged: (p0) => _serachItemModel(),
                              maxLines: 1,
                              onFieldSubmitted: (value) => _serachItemModel(),
                              label: null,
                              hintText: "Search Code",
                              controller: _searchController,
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    var res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SimpleBarcodeScannerPage(),
                                        ));
                                    setState(() {
                                      if (res is String) {
                                        _searchController.text = res;
                                        _serachItemModel();
                                        setState(() {});
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.qr_code)),
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: itemModel.length,
                            itemBuilder: (context, index) {
                              if (itemModel[index].PLAN_STATUS == "Close") {
                                return const SizedBox.shrink();
                              }

                              return itemModel.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/ScanPage', arguments: {
                                          'planCode': itemModel[index].PLAN_CODE
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 15,
                                          color: Colors.white,
                                          shape: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: itemModel[index]
                                                          .PLAN_STATUS ==
                                                      "Open"
                                                  ? colorActive
                                                  : colorPrimary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "Code : ${itemModel[index].PLAN_CODE}"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "Details : ${itemModel[index].PLAN_DETAILS ?? "-"}"),
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(itemModel[index].PLAN_CHECKDATE.toString()))}"),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                              width: 150,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 21,
                                                                vertical: 7,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: itemModel[index]
                                                                            .PLAN_STATUS ==
                                                                        "Open"
                                                                    ? colorActive
                                                                    : colorPrimary,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            12),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            14)),
                                                              ),
                                                              child: Text(
                                                                "${itemModel[index].PLAN_STATUS}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
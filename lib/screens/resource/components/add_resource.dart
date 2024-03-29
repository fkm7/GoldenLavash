import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/resource.dart' as resDb;
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/services/api.dart';
import 'package:http/http.dart' as http;

class AddResourcePage extends StatefulWidget {
  final Function(int statusCode) onSubmit;

  AddResourcePage({@required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _AddResourceState();
}

class Option {
  Option({this.title, this.value});

  String title;
  String value;
}

class _AddResourceState extends State<AddResourcePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _editTypeController = TextEditingController();
  var resourceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить сырьё'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(24),
                right: ScreenUtil().setWidth(24),
                top: ScreenUtil().setHeight(24),
                bottom: ScreenUtil().setHeight(12)),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Название',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(24),
                right: ScreenUtil().setWidth(24),
                top: ScreenUtil().setHeight(12),
                bottom: ScreenUtil().setHeight(24)),
            child: DropdownButtonFormField<Option>(
              decoration: InputDecoration(
                  labelText: 'Тип',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              items: <Option>[
                Option(title: 'Кухня', value: 'kitchen'),
                Option(title: 'Запчасть', value: 'part'),
              ]
                  .map((e) => DropdownMenuItem<Option>(
                        value: e,
                        child: Text(e.title),
                      ))
                  .toList(),
              onChanged: (value) {
                resourceType = value.value;
              },
            ),
          ),
          Container(
            child: RaisedButton(
              color: AppColors.buttonColor,
              textColor: Colors.white,
              child: Text('Сохранить'),
              onPressed: () {
                final resource = new Resource(
                  title: _titleController.text,
                  editType: 0,
                  resourceType: resourceType,
                );
                Future.sync(() async {
                  http.Response response =
                      await ApiService.getInstance().sendResource(resource);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    await Floor.instance.database.then((db) => db.resourceDao
                        .insertResource(resDb.Resource.fromJson(
                            json.decode(utf8.decode(response.bodyBytes)))));
                    widget.onSubmit(response.statusCode);
                  }
                });
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

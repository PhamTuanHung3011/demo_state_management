import 'package:demo_state_management/providers/product_provider.dart';
import 'package:demo_state_management/screens/user_products_screens.dart';
import 'package:demo_state_management/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _editProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    isFavorite: false,
  );

  bool _isInit = true;

  var _initValue = {
    'title': '',
    'price': 0,
    'description': '',
    'imageUrl': '',
  };

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<ProductProvider>(context, listen: false)
        .addProduct(_editProduct);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final idProduct = ModalRoute.of(context)!.settings.arguments as String;
      if (idProduct != null) {
        _editProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(idProduct);
        _initValue = {
          'title': _editProduct.title,
          'price': _editProduct.price,
          'description': _editProduct.description,
          //
          'imageUrl' : '',
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditScreens'),
        actions: <Widget>[
          IconButton(
              onPressed: _saveForm, icon: Icon(Icons.safety_check_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'] as String,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a title';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editProduct = Product(
                      id: '',
                      title: value.toString(),
                      description: _editProduct.description,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl,
                      isFavorite: _editProduct.isFavorite);
                },
              ),
              TextFormField(
                initialValue: _initValue['price'].toString(),
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Price must be greater than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: '',
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editProduct.imageUrl,
                      isFavorite: _editProduct.isFavorite);
                },
              ),
              TextFormField(
                initialValue: _initValue['description'] as String,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a description';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: '',
                      title: _editProduct.title,
                      description: value.toString(),
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl,
                      isFavorite: _editProduct.isFavorite);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    margin: EdgeInsets.only(top: 8.0, right: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text(' Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image Url',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a URL image';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'please  enter a valid url.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'please enter a valid url.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editProduct = Product(
                            id: '',
                            title: _editProduct.title,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            imageUrl: value.toString(),
                            isFavorite: _editProduct.isFavorite);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

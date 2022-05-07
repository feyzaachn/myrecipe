import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text('Çorbalar'),value: 'Çorbalar'),
    const DropdownMenuItem(child: Text('Etli Yemekler'),value: 'Etli Yemekler'),
    const DropdownMenuItem(child: Text('Ana Yemekler'),value: 'Ana Yemekler'),
    const DropdownMenuItem(child: Text('Deniz Ürünleri'),value: 'Deniz Ürünleri'),
    const DropdownMenuItem(child: Text('Dolmalar'),value: 'Dolmalar'),
    const DropdownMenuItem(child: Text('Zeytinyağlılar'),value: 'Zeytinyağlılar'),
    const DropdownMenuItem(child: Text('Hamur İşleri'),value: 'Hamur İşleri'),
    const DropdownMenuItem(child: Text('Ekmekler'),value: 'Ekmekler'),
    const DropdownMenuItem(child: Text('Börekler'),value: 'Börekler'),
    const DropdownMenuItem(child: Text('Pilavlar'),value: 'Pilavlar'),
    const DropdownMenuItem(child: Text('Makarnalar'),value: 'Makarnalar'),
    const DropdownMenuItem(child: Text('Tatlılar'),value: 'Tatlılar'),
    const DropdownMenuItem(child: Text('Pastalar'),value: 'Pastalar'),
    const DropdownMenuItem(child: Text('Kurabiyeler'),value: 'Kurabiyeler'),
    const DropdownMenuItem(child: Text('Sağlıklı Tarifler'),value: 'Sağlıklı Tarifler'),
    const DropdownMenuItem(child: Text('Şipşak Tarifler'),value: 'Şipşak Tarifler'),
    const DropdownMenuItem(child: Text('Reçeller'),value: 'Reçeller'),
    const DropdownMenuItem(child: Text('İçecekler'),value: 'İçecekler'),
    const DropdownMenuItem(child: Text('Salata-Mezeler'),value: 'Salata-Mezeler'),
    const DropdownMenuItem(child: Text('Dünya Yemekleri'),value: 'Dünya Yemekleri'),
    const DropdownMenuItem(child: Text('Yöresel Yemekler'),value: 'Yöresel Yemekler'),
    const DropdownMenuItem(child: Text('Turşular'),value: 'Turşular'),
    const DropdownMenuItem(child: Text('Diğer'),value: 'Diğer'),
  ];
  return menuItems;
}
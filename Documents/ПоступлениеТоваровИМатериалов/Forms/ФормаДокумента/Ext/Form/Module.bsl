﻿#Область ОбработчикиСобытий
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)    
	Если НЕ ЗначениеЗаполнено(Объект.АвторДокумента) Тогда
		Объект.АвторДокумента = ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;
КонецПроцедуры   

&НаКлиенте
Процедура НоменклатураКоличествоПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Номенклатура.ТекущиеДанные;
	РаботаСТабличнымиЧастямиКлиент.ПересчитатьСуммуВСтрокеТабличнойЧасти(СтрокаТЧ);
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураПриИзменении(Элемент)
	Объект.СуммаДокумента = Объект.Номенклатура.Итог("Сумма");
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураЦенаПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Услуги.ТекущиеДанные;
	РаботаСТабличнымиЧастямиКлиент.ПересчитатьСуммуВСтрокеТабличнойЧасти(СтрокаТЧ);	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураНоменклатураПриИзменении(Элемент)
	//СтрокаТЧ = Элементы.Номенклатура.ТекущиеДанные;
	//Если ЗначениеЗаполнено(СтрокаТЧ.Номенклатура) Тогда
	//	СтрокаТЧ.Цена = ПолучитьЦенуНаКонкретнуюДату(СтрокаТЧ.Номенклатура, Объект.Поставщик, Объект.Дата)
	//Иначе
	//	СтрокаТЧ.Цена = 0;
	//КонецЕсли;                
	
	ТекущиеДанные = Элементы.Номенклатура.ТекущиеДанные;
	Цена = РаботаСЦенами.ПолучитьЦенуНаКонкретнуюДату(ТекущиеДанные.Номенклатура, Объект.Поставщик, Объект.Дата);
	ТекущиеДанные.Цена = Цена;
КонецПроцедуры    

//Функция ПолучитьЦенуНаКонкретнуюДату(Номенклатура, Поставщик, ДатаЦены) Экспорт
//	Запрос = Новый Запрос;
//	Запрос.Текст = "ВЫБРАТЬ
//	               |	ЦеныНоменклатурыПоставщиковСрезПоследних.Цена КАК Цена
//	               |ИЗ
//	               |	РегистрСведений.ЦеныНоменклатурыПоставщиков.СрезПоследних(
//	               |			&ДатаДокумента,
//	               |			Номенклатура = &Номенклатура
//	               |				И Поставщик = &Поставщик) КАК ЦеныНоменклатурыПоставщиковСрезПоследних";
//	
//	Запрос.УстановитьПараметр("ДатаДокумента", ДатаЦены);
//	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
//	Запрос.УстановитьПараметр("Поставщик", Поставщик);
//	
//	РезультатЗапроса = Запрос.Выполнить().Выбрать();
//	Пока РезультатЗапроса.Следующий() Цикл
//		возврат РезультатЗапроса.Цена;
//	КонецЦикла;	
//КонецФункции
#КонецОбласти

#Область ОбработчикиКомандФормы
 &НаКлиенте
Процедура ОбновитьЦены(Команда)
	Для Каждого Строка ИЗ Объект.Номенклатура Цикл
		Строка.Цена = РаботаСЦенами.ПолучитьЦенуНаКонкретнуюДату(Строка.Номенклатура, Объект.Поставщик, Объект.Дата);
    КонецЦикла;
КонецПроцедуры                                                                                                      
#КонецОбласти
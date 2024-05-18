﻿#Область ОбработчикиСобытий
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если НЕ ЗначениеЗаполнено(Объект.АвторДокумента) Тогда
		Объект.АвторДокумента = ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;   	
КонецПроцедуры  

&НаКлиенте
Процедура ПриОткрытии(Отказ)
УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура ВидОперацииПриИзменении(Элемент)
	МассивОчищаемыхРеквизитов = Новый Массив;

	Если (Объект.ВидОперации =  ПредопределенноеЗначение("Перечисление.ВидыОперацийРасходаДенег.ВыдачаДенегПодотчетнику")
	    ИЛИ Объект.ВидОперации =  ПредопределенноеЗначение("Перечисление.ВидыОперацийРасходаДенег.ВзносНаличнымиВБанк") )
	    И ЗначениеЗаполнено(Объект.ДоговорКонтрагента) Тогда
	    МассивОчищаемыхРеквизитов.Добавить("ДоговорКонтрагента");

	ТекстВопроса = "При изменении реквизита ""Вид операции"" будут очищены следующие данные:
	    | - Договор
	    | Продолжить?";
	КонецЕсли;

	Если ЗначениеЗаполнено(МассивОчищаемыхРеквизитов) Тогда
	    Оповещение = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбИзмененииВидаОперации", ЭтаФорма, МассивОчищаемыхРеквизитов);
	    ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет,,,"Внимание!");
	Иначе
	    ВидОперации =  Объект.ВидОперации;
	    УстановитьВидимость();
	КонецЕсли;
КонецПроцедуры 

 &НаКлиенте
Процедура ПолучательПриИзменении(Элемент) 
	ЭтоПоставщик = ПроверитьВидимостьДоговораВЗависимостиОтТипаКонтрагента(Объект.Получатель);
	МассивОчищаемыхРеквизитов = Новый Массив;

	Если НЕ ЭтоПоставщик И ЗначениеЗаполнено(Объект.ДоговорКонтрагента) Тогда
	    МассивОчищаемыхРеквизитов.Добавить("ДоговорКонтрагента");

	    ТекстВопроса = "При изменении реквизита ""Получатель"" будут очищены следующие данные:
	    | - Договор
	    | Продолжить?";
	КонецЕсли;

	Если ЗначениеЗаполнено(МассивОчищаемыхРеквизитов) Тогда
	    Оповещение = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбИзмененииПолучатель", ЭтаФорма, МассивОчищаемыхРеквизитов);
	    ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет,,,"Внимание!");
	Иначе
	    Получатель =  Объект.Получатель;
	    УстановитьВидимость();
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции  
&НаКлиенте
Процедура УстановитьВидимость()
	СтрокаТипПолучателя = "";   
	
	Если Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийРасходаДенег.ВыдачаДенегПодотчетнику") Тогда
    	Элементы.ДоговорКонтрагента.Видимость = Ложь;
    	Элементы.Получатель.Видимость = Истина;
    	СтрокаТипПолучателя = "СправочникСсылка.Сотрудники";
	ИначеЕсли Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийРасходаДенег.ВзносНаличнымиВБанк") Тогда
		Элементы.ДоговорКонтрагента.Видимость = Ложь;
		Элементы.Получатель.Видимость = Истина;
		Элементы.РасчетныйСчет.Видимость = Истина; 
		СтрокаТипПолучателя = "СправочникСсылка.Банки";
	ИначеЕсли Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийРасходаДенег.ВозвратДенегПокупателю") 
		ИЛИ Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийРасходаДенег.ОплатаПоставщику") Тогда
		Элементы.ДоговорКонтрагента.Видимость = Истина;
    	Элементы.Получатель.Видимость = Истина;
    	СтрокаТипПолучателя = "СправочникСсылка.Контрагенты";
		Элементы.РасчетныйСчет.Видимость = Ложь; 
	Иначе
    	Элементы.ДоговорКонтрагента.Видимость = Истина;
    	Элементы.Получатель.Видимость = Истина;
	КонецЕсли;  
	
	Если ЗначениеЗаполнено(СтрокаТипПолучателя) Тогда
    	Массив = Новый Массив();
    	Массив.Добавить(Тип(СтрокаТипПолучателя));
    	ОписаниеТипаПолучателя = Новый ОписаниеТипов(Массив);
    	Элементы.Получатель.ОграничениеТипа = ОписаниеТипаПолучателя;
	КонецЕсли;

	Если Элементы.ДоговорКонтрагента.Видимость = Истина
    	И ЗначениеЗаполнено(Объект.Получатель) Тогда
    	Элементы.ДоговорКонтрагента.Видимость = ПроверитьВидимостьДоговораВЗависимостиОтТипаКонтрагента(Объект.Получатель);
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроверитьВидимостьДоговораВЗависимостиОтТипаКонтрагента(Получатель)
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Получатель", Получатель);
	Запрос.Текст = "ВЫБРАТЬ
            	   |    Контрагенты.ТипКонтрагента КАК ТипКонтрагента,
            	   |    Контрагенты.Ссылка КАК Контрагент
            	   |ИЗ
            	   |    Справочник.Контрагенты КАК Контрагенты
            	   |ГДЕ
            	   |    Контрагенты.Ссылка = &Получатель";

	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();

	Если ЗначениеЗаполнено(Выборка.ТипКонтрагента)
   		И Выборка.ТипКонтрагента = Перечисления.ТипыКонтрагентов.Клиент Тогда
   		возврат Ложь;
	Иначе
    	возврат Истина;
	КонецЕсли; 
КонецФункции

&НаКлиенте
Процедура ПослеОтветаНаВопросОбИзмененииВидаОперации(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
	    Для Каждого Реквизит Из ДополнительныеПараметры Цикл
	        Объект[Реквизит] = Неопределено;
	    КонецЦикла;
	    УстановитьВидимость();
	    ВидОперации =  Объект.ВидОперации;
	Иначе
	    Объект.ВидОперации = ВидОперации;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопросОбИзмененииПолучатель(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
	    Для Каждого Реквизит Из ДополнительныеПараметры Цикл
	        Объект[Реквизит] = Неопределено;
	    КонецЦикла;
	    УстановитьВидимость();
	    Получатель =  Объект.Получатель;
	Иначе
	    Объект.Получатель = Получатель;
	КонецЕсли;
КонецПроцедуры
#КонецОбласти


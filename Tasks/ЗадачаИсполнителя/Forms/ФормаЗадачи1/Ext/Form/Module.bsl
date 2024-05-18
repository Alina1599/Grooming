﻿#Область ОбработчикиСобытий
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьКартуМаршрута();
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ОбновитьКартуМаршрута();
КонецПроцедуры
  
&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	ОбновитьКартуМаршрута();
КонецПроцедуры
#КонецОбласти    

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура Обновить(Команда)
	ОбновитьКартуМаршрута();
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ОбновитьКартуМаршрута()
	БизнесПроцессОбъект = РеквизитФормыВЗначение("Объект");
	КартаМаршрута = БизнесПроцессОбъект.БизнесПроцесс.ПолучитьОбъект().ПолучитьКартуМаршрута();
КонецПроцедуры
								
&НаКлиенте
Процедура КартаМаршрутаПриИзменении(Элемент)
	ОбновитьКартуМаршрута();
КонецПроцедуры
#КонецОбласти


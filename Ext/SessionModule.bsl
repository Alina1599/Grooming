﻿#Область СлужебныеПроцедурыИФункции
Процедура УстановкаПараметровСеанса(ИменаПараметровСеанса)
Если ИменаПараметровСеанса = Неопределено Тогда
    // Раздел установки параметров сеанса при начале сеанса (ИменаПараметровСеанса = Неопределено)
    // Выполняется установка параметров сеанса, которые можно инициализировать
    // при начале работы системы
Иначе
    // Установка параметров сеанса "по требованию"
    // Параметры сеанса, инициализация которых требует обращения к одним и тем же данным
    // следует инициализировать сразу группой. Для того, чтобы избежать их повторной инициализации,
    // имена уже установленных параметров сеанса сохраняются в массиве УстановленныеПараметры
    УстановленныеПараметры = Новый Массив;
    Для Каждого ИмяПараметра Из ИменаПараметровСеанса Цикл
        УстановитьЗначениеПараметраСеанса(ИмяПараметра, УстановленныеПараметры);
    КонецЦикла;
КонецЕсли;
КонецПроцедуры
	
Процедура УстановитьЗначениеПараметраСеанса(Знач ИмяПараметра, УстановленныеПараметры)
	Если УстановленныеПараметры.Найти(ИмяПараметра) <> Неопределено Тогда
    	Возврат;
	КонецЕсли;

Если ИмяПараметра = "ТекущийПользователь" Тогда
    ПользовательИБ = ПользователиИнформационнойБазы.ТекущийПользователь();
	Если ПользовательИБ = Неопределено Тогда
        Возврат;
    КонецЕсли;

    ТекущийПользователь = Справочники.Пользователи.НайтиПоКоду(ПользовательИБ.УникальныйИдентификатор);

    Если ТекущийПользователь.Пустая() Тогда
        ПользовательОбъект = Справочники.Пользователи.СоздатьЭлемент();
        ПользовательОбъект.Код = ПользовательИБ.УникальныйИдентификатор;
        ПользовательОбъект.Наименование = ПользовательИБ.Имя;
        ПользовательОбъект.Записать();  
		ТекущийПользователь = ПользовательОбъект.Ссылка;
    КонецЕсли;
    ПараметрыСеанса.ТекущийПользователь = ТекущийПользователь;
КонецЕсли;
	УстановленныеПараметры.Добавить(ИмяПараметра);
КонецПроцедуры
#КонецОбласти
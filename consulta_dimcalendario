let

    FechaInicio = #date(2025, 1, 1),
    FechaFin = #date(2025, 12, 31),

    TotalDias = Duration.Days(Duration.From(FechaFin - FechaInicio)) + 1,
    ListaFechas = List.Dates(FechaInicio, TotalDias, #duration(1, 0, 0, 0)),

    TablaBase = Table.FromList(ListaFechas, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Columnas renombradas" = Table.RenameColumns(TablaBase,{{"Column1", "Fecha"}}),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Columnas renombradas",{{"Fecha", type date}}),
    
    #"Año Añadido" = Table.AddColumn(#"Tipo cambiado", "Año", each Date.Year([Fecha]), Int64.Type),
    #"Mes Añadido" = Table.AddColumn(#"Año Añadido", "Mes", each Date.Month([Fecha]), Int64.Type),
    #"Nombre Mes Añadido" = Table.AddColumn(#"Mes Añadido", "NombreMes", each Date.MonthName([Fecha], "es-ES"), type text),
    #"Trimestre Añadido" = Table.AddColumn(#"Nombre Mes Añadido", "Trimestre", each Date.QuarterOfYear([Fecha]), Int64.Type),
    #"Día Semana Añadido" = Table.AddColumn(#"Trimestre Añadido", "DíaSemana", each Date.DayOfWeek([Fecha], Day.Monday) + 1, Int64.Type),
    #"Nombre Día Añadido" = Table.AddColumn(#"Día Semana Añadido", "Día", each Date.Day([Fecha]), Int64.Type)
in
    #"Nombre Día Añadido"

let
    Token = "18e0dc69b54867f5269435bb689ca477c037a90ad4c5743df750dbb4c4a7b065",

    IndicadorID = "10037",

    NombreIndicador = "Eólica",

    FechaInicio = "2025-01-01T00:00",

    FechaFin = "2025-03-31T23:59",

    Url =
        "https://api.esios.ree.es/indicators/"
        & IndicadorID
        & "?start_date="
        & FechaInicio
        & "&end_date="
        & FechaFin
        & "&time_trunc=day",

    Source =
        Json.Document(
            Web.Contents(
                Url,
                [
                    Headers = [
                        #"Accept" = "application/json; application/vnd.esios-api-v1+json",
                        #"Content-Type" = "application/json",
                        #"x-api-key" = Token
                    ],
                    Timeout = #duration(0,0,5,0)
                ]
            )
        ),

    indicator = Source[indicator],

    values = indicator[values],

    Tabla =
        Table.FromList(
            values,
            Splitter.SplitByNothing(),
            null,
            null,
            ExtraValues.Error
        ),

    Expandido =
        Table.ExpandRecordColumn(
            Tabla,
            "Column1",
            {"datetime", "value"},
            {"Fecha", "Valor"}
        ),

    Tipo =
        Table.TransformColumnTypes(
            Expandido,
            {
                {"Fecha", type datetimezone},
                {"Valor", type number}
            }
        ),

    Indicador =
        Table.AddColumn(
            Tipo,
            "Indicador",
            each NombreIndicador
        ),

    Ordenado =
        Table.Sort(
            Indicador,
            {
                {"Fecha", Order.Ascending}
            }
        )

in
    Ordenado

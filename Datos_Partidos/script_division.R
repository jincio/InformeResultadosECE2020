## Script
# Code to get a file for each party (to share)

partidos=c("ACCION POPULAR",
           "ALIANZA PARA EL PROGRESO",
           "EL FRENTE AMPLIO POR JUSTICIA, VIDA Y LIBERTAD",
           "FRENTE POPULAR AGRICOLA FIA DEL PERU - FREPAP",
           "FUERZA POPULAR","PARTIDO MORADO",
           "PODEMOS PERU","PARTIDO DEMOCRATICO SOMOS PERU",
           "UNION POR EL PERU")


informes_partidos<-function(partido)
{
  dir.create(partido)
  file1=paste0(partido,"/",partido,"_distrital.xlsx")
  file2=paste0(partido,"/",partido,"_provincial.xlsx")
  distrital=resultados%>%
    filter(!Departamento %in% c("AFRICA", "AMERICA", "ASIA", 
                                "EUROPA", "OCEANIA") &
             Partido==partido)%>%
    dplyr::select(Departamento,Provincia, Distrito,Partido,
                  Votos=votos, Porcentaje=porcentaje,
                  Ranking=ranking)
  provincial=resultados%>%
    filter(!Departamento %in% c("AFRICA", "AMERICA", "ASIA", 
                                "EUROPA", "OCEANIA")&
             Partido==partido)%>%
    dplyr::select(Departamento,Provincia,Partido,
                  Votos=votos_p, Porcentaje=porcent_p)%>%
    unique()
  export(distrital,file1)
  export(provincial,file2)
}

for (p in partidos){
  informes_partidos(p)
}


export(resultados,file=file1, sheetName="Distrital")
export(resultados,file=file2, sheetName="Provincial",append=TRUE)

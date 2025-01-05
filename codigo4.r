---
title: "Análisis Exploratorio de Datos con mtcars"
author: "Tu Nombre"
date: "`r Sys.Date()`"
output:
  html_document:
    toc: true
    toc_depth: 3
    number_sections: true
    theme: journal
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE, warning = FALSE, message = FALSE)
library(dplyr)
library(tidyr)
library(ggplot2)
library(knitr)
library(kableExtra)
library(DT)
# Cargar el dataset mtcars
data(mtcars)
df <- as_tibble(mtcars)

# Mostrar las primeras filas del dataset
head(df)
# Tabla estática con kable
df %>%
  head(10) %>%
  kable(caption = "Primeras filas del dataset mtcars") %>%
  kable_styling(full_width = FALSE, bootstrap_options = c("striped", "hover"))
# Tabla interactiva con DT
datatable(df, options = list(pageLength = 5), caption = "Dataset mtcars interactivo")
# Gráfico de dispersión
ggplot(df, aes(x = hp, y = mpg)) +
  geom_point(color = "blue", size = 3, alpha = 0.7) +
  labs(title = "Relación entre caballos de fuerza (hp) y millas por galón (mpg)",
       x = "Caballos de fuerza (hp)",
       y = "Millas por galón (mpg)") +
  theme_minimal()
# Histograma de mpg
ggplot(df, aes(x = mpg)) +
  geom_histogram(fill = "skyblue", color = "black", bins = 10) +
  labs(title = "Distribución de millas por galón (mpg)",
       x = "Millas por galón (mpg)",
       y = "Frecuencia") +
  theme_minimal()

== RIFAPP

Gestor de Rifas

Integrantes:

* Fernando Lizana
* Diego Fernández

# Versiones

* Ruby v2.4.0p0
* Rails v4.2.0
* Bundler v1.8.0
* PostgreSQL (psql) v9.4.4

# Configuraciones

## Setup

Por favor asegurarse de tener instaladas todas las versiones de *Ruby*, *Rails*, *Bundler* y *PostgreSQL*.

`git clone https://github.com/https://github.com/IIC2513-2017-1/grupo-16`
`cd grupo-16`
`bundle install`

## Crear Base de Datos

* Instalar PostgreSQL (v9.4.4)

* Base de datos de desarrollo

`createdb rifapp-web_development`
`psql rifapp-web_development` (Para abrir _shell_ de PostgreSQL)

## Tests

Para correr tests ejecutar el siguiente comando

`bin/rails tests`

## Producción

* URL de Producción: `https://rifapp-web.herokuapp.com/`
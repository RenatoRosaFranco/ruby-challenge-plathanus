<div align="center">
 
  ## Roman Numerals Converter (Ruby)

  <br/>
  
  ![Ruby](https://img.shields.io/badge/Ruby-3.2+-red)
  ![RSpec](https://img.shields.io/badge/tests-RSpec-green)
  [![CI](https://github.com/RenatoRosaFranco/ruby-challenge-plathanus/actions/workflows/ci.yml/badge.svg)](https://github.com/RenatoRosaFranco/ruby-challenge-plathanus/actions/workflows/ci.yml)
  ![License](https://img.shields.io/badge/license-MIT-blue)
 </div>

Converte um **numero natural** (inteiro positivo) para seu equivalente em
**algarismos romanos**, <br>seguindo as regras clássicas (inclui notação subtrativa):
IV, IX, XL, XC, CD, CM).

Projeto orientado a objetos, com **validação, errors específicos e testes RSpec.**

## Sumario
 - [Requisitos](#requisitos)
 - [Instalação](#instalação)
 - [Estrutura do Projeto](#estrutura-do-projeto)
 - [Uso Rápido](#uso-rápido)
 - [Erros](#erros)
 - [Testes](#testes)
 - [Qualidade e estilo](#qualidade-e-estilo)
 - [Commits semânticos](#commits-semânticos)
 - [Notas de design](#notas-de-design)

## Requisitos
  - Ruby 3.x **(recomendado)**
  - Bundler
  - RSpec **(adicionado via bundle add rspec)**

## Instalação

```
  bundle install
```

### Estrutura do projeto

```bash
lib/
  roman_numeral_converter.rb
  utils/
    roman_dictionary.rb
spec/
  roman_numeral_converter_spec.rb
README.md
```

## Uso rápido

```ruby
require_relative "lib/roman_numeral_converter"

RomanNumeralConverter.new(1994).to_roman
# => "MCMXCIV"

RomanNumeralConverter.new(2024).to_roman
# => "MMXXIV"
```

## Erros

A classe expõe errors especifícos (subclasse de StandardError):
- `RomanNumeralConverter::NonIntegerError` — quando `number` **não é** `Integer`.
- `RomanNumeralConverter::OutOfRangeError` — quando `number` **está fora de** `min..max`.

exemplo

```ruby

begin
  RomanNumeralConverter.new("10").to_roman
rescue RomanNumeralConverter::NonIntegerError => e
  puts e.message
end
```

## Testes

Executar a suíte RSpec:

```bash
  bundle exec rspec
```

A suite cobre:
  - Validação de tipo e faixa
  - Unidades básicas
  - Notação subtrativa
  - Casos representativos
  - Restrições de forma (caracteres válidos, repetições e pares subtrativos)
  - Limites (1 e 3.999)
  - Imutabilidade do número armazenado

## Qualidade e estilo
  - Tabela de conversão congelada para imutabilidade
  - Módulo RomanDictionary centraliza constantes/tabela
  - Validação clara, mensagem de erro **descritivas**

## Commits semânticos
Use **Conventional Commits**
  
  - **feat:** nova funcionalidade
  - **fix:** correção de bug
  - **test:** alterações nos testes
  - **refactor:** refatoração sem mudança de comportamento

## Notas de design
  - Intervalo configurável (min, max) para usos menos restritos.
  - Erros especifícos ajudam a tratar falhas com precisão

## Licensa
MIT - use livremente com atribuição.

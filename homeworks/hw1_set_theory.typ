#import "common.typ": *

#show: template

#set page(
  paper: "a4",
  margin: (top: 3cm, rest: 2cm),
  header: [
    #set text(10pt)
    #smallcaps[*Домашняя работа \#1*]
    #h(1fr)
     #link("https://dm-aisd.yonote.ru/share/itmo_dm_aisd")[*Дискретная математика*]
    \
    *Теория множеств*
    #h(1fr)
    *$#emoji.leaf.maple$ Осень 2026*
    #place(bottom, dy: 0.4em)[
      #line(length: 100%, stroke: 0.6pt)
    ]
  ],
  numbering: "— 1 —"
)

#let Jac = $cal(J)$ 
#let power(x) = $scr(P)(#x)$
#let card(x) = $abs(#x)$

#Block[
  Напоминание об уровнях заданий:

  #TagCore это _обязательные_ к выполнению задачи базового уровня сложности. За них вы получаете баллы.

  #TagChallenge это _не обязательные_ задачи повышенного уровня сложности. Они не входят в итоговую оценку. Однако за их решение можно получить плюсик в карму. _Возможно_, плюсики в карму в конце семестра преобразуются в нечто большее.

  #TagBonus это _не обязательные_ задачи высокого уровня сложности, за решение которых можно получить _доп баллы_. Однако стоит учитывать: задания этого уровня могут быть сильно сложнее основной части домашней работы, могут потребовать знаний вне рамок курса, а также имеют особое требование --- каждая такая задача требует _защиты_.
]


== Problem 1. Базовое понимание множеств. #h(1fr) #TagCore

#tasklist("prob1")[
+ *Мощность.* Сколько элементов в каждом из множеств?
  #tasklist("prob1a", cols: 2, format: "(a)")[
    + ${{a},{b,c}, d}$
    
    + $ {3, {4,5,6}, {3,4}, 6}$
    + ${x, {x, y}, {x, {y}}, y}$
    + ${x, y, {x}, {y}, {x, y}, emptyset}$
    + ${{x, emptyset}, {{x}, emptyset}, x}$
    #colbreak()
    + $emptyset$
    
    + ${emptyset, {emptyset}, {{emptyset}}, {emptyset, {emptyset}}}$
    + ${{{emptyset}}}$
    + ${emptyset, {emptyset}, {{emptyset}}, {{{emptyset}}}}$
    
  ]

+ *Принадлежность и подмножества.* Определить истинность утверждений $(a eq.not b)$:
  #tasklist("prob1b", cols: 2, format: "(a)")[
    + $a in {{a}, b}$
    
    + $a in {a, {b}}$
    + ${a} in {a, {a}}$
    + ${a} subset {a, b}$
    + ${a} subset.eq {{a}, {b}}$
    + ${{a}} subset {{a}, {a, b}}$
    + ${{a}, b} subset.eq {a, {a, b}, {b}}$
    + ${a, a} union {a, a, a} = {a, a, a, a, a}$
    + ${a, a} union {a, a, a} = {a}$
    + ${a, a} inter {a, a, a} = {a}$
    + ${a, a} inter {a, a, a} = {a, a}$
    + ${a, a, a} \\ {a, a} = {a}$
    + $emptyset in emptyset$
    #colbreak()
    + $emptyset subset.eq emptyset$
    
    + $emptyset subset emptyset$
    + $emptyset in {emptyset}$
    + $emptyset subset.eq {{emptyset}}$
    + ${emptyset, emptyset} subset {emptyset}$
    + ${{emptyset}} subset {{emptyset}, {emptyset}}$
    + $a in 2^{a}$
    + $2^{a,emptyset} subset 2^{a,b,emptyset}$
    + ${a, b} subset.eq 2^{a,b}$
    + ${a, a} in 2^{a,a}$
    + ${{a}, emptyset} subset.eq 2^{a,a}$
    + ${a, {a}} subset 2^{a,2^{a}}$
    + ${{a, {emptyset}}} subset.eq 2^{a,2^emptyset}$
  ]
]
#pagebreak()
== Problem 2. Операции над множествами #h(1fr) #TagCore
#tasklist("prob2")[
+ *Простейшие примеры.*
  Даны следующие множества: $A = {1, 2, 4}, B = {square} union emptyset, C = 2^emptyset \\ {emptyset}, D = {4, card(2^{∅,C})}.$ Требуется найти:
  #tasklist("task3", cols: 2, format: "(a)")[
  + A $triangle$ D
  + C $times$ B
  + B $inter$ A
  #colbreak()
  + B $times 2^C$
  + $D^(card(C))$
  + ${D inter {A}} times (D union {card(D)})$
]
+ *Упрощение выражений.* Упростите выражения, поэтапно применяя законы и свойства операций. На каждом шаге подписывайте, какое свойство/закон вы применили:
  #tasklist("prob2b", cols: 1, format: "(a)")[
  + $(B inter C inter D) union (C inter D) union (A inter C inter D)$
  + $(A union overline(B)) inter (A union overline(B) union C) inter (A union overline(B) union D)$
  ]

+ *Анализ утверждений.* Определите, какие из следующих утверждений верны. Обоснуйте ответ:
  #tasklist("prob2c", cols: 1, format: "(a)")[
  + $A subset.eq A union B$
  + $A inter (B union C) = (A inter B) union (A inter C)$
  + $(A union B) \\ C = (A \\ C) ∪ (B \\ C)$
  ]

+ *Немного доказательств.* Докажите тождества, используя законы:
  #tasklist("prob2d", cols: 1, format: "(a)")[
  + $A inter (B union overline(A)) = A inter B$
  + $A union (B\\C) = (A inter B)\\(A inter C)$
  ]
]

== Problem 3. Схожесть и Расстояние. #h(1fr) #TagCore
#link("https://ru.wikipedia.org/wiki/Коэффициент_Жаккара")[#text(fill:accent)[#underline[*Мера Жаккара*]]] #Jac (A, B) для двух конечных множеств A и B определяет степень их
похожести и задаётся следующим образом:

$ cal(J) (A, B) = (card(A inter B))/ (card(A union B))  $

При этом #Jac $(emptyset, emptyset) = 1$. Расстояние Жаккара $d_Jac (A, B)$ между двумя множествами A и B
определяет степень их различия и задаётся как $d_Jac (A, B) = 1 − Jac (A, B)$.\
Докажите следующие утверждения для произвольных конечных множеств A и B.
#tasklist("prob3", cols: 1)[
+ $Jac (A, A) = 1 #text[ и ] d_Jac (A, A) = 0 $
+ $Jac (A, B) = Jac (B, A) #text[ и ] d_Jac (A, B) = d_Jac (B, A).$
]
== Problem 4. Свойства и законы. #h(1fr) #TagCore
Докажите или опровергните следующее утверждение: 

Если $A$ и $B$ --- множества в универсуме $U$, то $A$ является подмножеством $B$ тогда и только тогда когда дополнение к $overline(A) union B = U.$
#pagebreak()
== Problem 5. Работа с диаграммами. #h(1fr) #TagCore
#tasklist("problem5",cols: 1, format: "1.")[
+ Задайте множество аналитически по закрашенной области на диаграмме Венна. Упростите полученные выражения.
#align(center)[
  #tasklist("prob5", cols:2)[
    #cetz.canvas({
      import cetz.draw: *
  
      scale(150%)
  
      cetz-venn.venn3(
        name: "example5_1",
        a-fill: blue.transparentize(80%),
        b-fill: blue.transparentize(80%),
        ab-fill: blue.transparentize(80%),
        
        abc-fill: blue.transparentize(80%),
        padding: 0.3,
      )
      content("example5_1.a",  text(size: 1.5em)[A], )
      content("example5_1.b",  text(size: 1.5em)[B], )
      content("example5_1.c",  text(size: 1.5em)[C], )
    })
    
    #align(center)[(a)]
  
    \
  
     #cetz.canvas({
      import cetz.draw: *
  
      scale(150%)
  
      cetz-venn.venn3(
        name: "example5_3",
        ac-fill: blue.transparentize(80%),
        b-fill: blue.transparentize(80%),
        ab-fill: blue.transparentize(80%),
        bc-fill: blue.transparentize(80%),
        abc-fill: blue.transparentize(80%),
        padding: 0.3,
      )
      content("example5_3.a",  text(size: 1.5em)[A], )
      content("example5_3.b",  text(size: 1.5em)[B], )
      content("example5_3.c",  text(size: 1.5em)[C], )
    })
    
    #align(center)[(c)]
    
    #colbreak()
    
    #cetz.canvas({
      import cetz.draw: *
  
      scale(150%)
  
      cetz-venn.venn3(
        name: "example5_2",
        not-abc-fill: blue.transparentize(80%),
        a-fill: blue.transparentize(1000%),
        b-fill: blue.transparentize(100%),
        c-fill: blue.transparentize(100%),
        
        
        padding: 0.3,
      )
      content("example5_2.a",  text(size: 1.5em)[A], )
      content("example5_2.b",  text(size: 1.5em)[B], )
      content("example5_2.c",  text(size: 1.5em)[C], )
    })
    
    #align(center)[(b)]
  
    \
  
    #cetz.canvas({
      import cetz.draw: *
  
      scale(150%)
  
      cetz-venn.venn3(
        name: "example5_4",
  
        a-fill: blue.transparentize(80%),
        b-fill: blue.transparentize(80%),
        
        abc-fill: blue.transparentize(80%),
        padding: 0.3,
      )
      content("example5_4.a",  text(size: 1.5em)[A], )
      content("example5_4.b",  text(size: 1.5em)[B], )
      content("example5_4.c",  text(size: 1.5em)[C], )
    })
    
    #align(center)[(d)]
  ]
]
+ Изобразите на диаграмме Венна:
  #tasklist("prob5b", format: "(a)", start: 5)[
  + $(A inter B) triangle C inter (A\\B)$
  
  + $(A union B) \\ C triangle (C\\A)$
  ]
  
+ Придумайте как представить 4 множества используя диаграммы Эйлера-Венна. С помощью вашего варианта диаграммы задайте:
#let nA = $overline(A)$
#let nB = $overline(D)$
#let nC = $overline(C)$
#let nD = $overline(D)$
  #tasklist("prob5b", format: "(a)", start: 7)[
    
  + $ (A inter B inter nC inter nD) union (A inter nB inter C inter nD) union (nA inter B inter C inter nD) union (A inter nB inter nC inter D) union \ union (nA inter B inter nC inter D) union (nA inter nB inter C inter D) $

  ]
]


#pagebreak()

== Problem 6. Само референтные конфигурации   #h(1fr) #TagChallenge
#v(0.5em)
#tasklist("prob6")[
+ Объясните, почему не может существовать множества $A$, такого что $A = {2, card(A)}.$
  
+ Найдите все тройки $(A, B, C)$, удовлетворяющие условию: 
  $
  A &= {1, card(B), card(C)}, \
  B &= {2, card(A), card(C)}, \
  C &= {1, 2, card(A), card(B)}.
  $
  Если решений нет, приведите доказательство отсутствия решения.
]
== Problem 7. Чуть больше про Булеан и Универсум #h(1fr) #TagChallenge
Ниже под $A$ и $B$ подразумеваются множества.
#tasklist("problem7", cols: 1)[
+ Всегда ли выполняется следующее утверждение? Если да --- докажите, если нет --- приведите контрпример.
  $ power(A inter B) =  power(A) inter power(B) $
+ А что насчет этого?
  $ power(A union B) =  power(A) union power(B) $
+ А что можно сказать/доказать об этом утверждении?
  $ power(A\\B)\\(power(A) \\ power(B)) $
  Подсказка: задайте множества $A$ и $B$ и посмотрите на конкретных примерах.
+ Поговорим немного о  вложенности множеств. На лекциях и практиках вам рассказали, что элементом множества может быть... другое множество, а также что множество можно задать некоторым правилом, которое выполняется для всех его элементов. Однако такой подход, называемый _наивной теорией множеств_, ведет к неприятной ситуации, которую вам и нужно _формально_ описать. Как бы вы предложили решить возникший "парадокс"?

  Подсказка: начните рассмотрения со свойства: $x in.not x - $ "не содержит самого себя в качестве элемента".
]

*_P.S._* Описать формально $=$ описать используя кванторы. Описание словами приветствуется, однако лишь в дополнение к описанию на кванторах.
\

#line(length: 100%, stroke: 0.4pt)
*Напоминание о требованиях к оформлению решений:*
- Для всех доказательств расписывайте каждый шаг вашего размышления, обязательно поставив Ч.Т.Д; Q.E.D или $square$ в конце.
- Пишите аккуратно, *разборчивым почерком*. Если ваш почерк будет больше похож на шифр, проверяющие оставляют за собою право *обнулить* результаты ваших стараний в связи с невозможностью их проверки. 
- Стоит быть осторожнее с использованием нейронных сетей... 
- Загружайте решение в формате PDF. 

#pagebreak()

#align(center)[
  #text(1.2em, weight: "bold", fill: accent)[Задачи уровня бонус]
]
#align(center)[В этой домашней работе нет задач подобного уровня, не уходя слишком далеко от программы  :(  

Однако если у вас есть интересные кандидаты или идеи --- пожалуйста, поделитесь)
]
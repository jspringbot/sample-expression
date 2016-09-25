*** Settings ***
Library     JSpringBotGlobal
Library     Collections

*** Variables ***
${domain_name}=    domain1

*** Test Cases ***
Simple expressions
    [Tags]  simple
    EL Should Be True      $[contains('alvin', 'vin')]
    EL Should Be True      $[1+1 eq 2]
    EL Should Be True      $[true]
    EL Should Be True      $[empty '']
    EL Should Be True      $[not empty 'not-empty']
    EL Should Be Null      $[null]
    EL Should Not Be Null  $['sample string']

Expressions with variables
    [Tags]  variables
    EL Add Variable        var1     a
    EL Add Variable        var2     a
    EL Add Variable        var3     $[i:3]
    EL Add Variable        var4     $[i:10]
    EL Should Be True      $[var3 + var4 eq 13]
    EL Should Be True      $[var4 > var3]
    EL Should Be True      $[var1 eq var2]

Expressions with methods
    [Tags]  methods
    EL Add Variable        str     sample string
    EL Should Be True      $[contains(str, 'sample')]
    EL Should Be True      $[startsWith(str, 'sample')]
    EL Should Be True      $[endsWith(str, 'string')]

Expression with inline variables
    [Tags]  inline-variables
    EL Should Be True      $[contains($1, $2)]                        alvin   vin
    EL Should Be True      $[$1 + $2 eq $3]                           1       1       2
    EL Should Be True      $[concat($1, $2, $3) eq 'abc']             a       b       c
    EL Should Be True      $[join('-', $1, $2, $3) eq 'a-b-c']        a       b       c

Expression with robot variables
    [Tags]  robot-variables
    # long
    ${sum}=     EL Evaluate     $[1 + 2]
    EL Should Be True           $[${sum} eq 3]
    # string
    ${str}=     EL Evaluate     $[join('-', $1, $2, $3)]    a   b   c
    EL Should Be True           $['${str}' eq 'a-b-c']

Expression Var Method
    [Tags]  var-method
    ${string}=              Set Variable            some string
    ${integer}=             Convert To Integer      100
    ${boolean}=             Convert To Boolean      true
    ${number}=              Convert To Number       42.512
    @{list} =               Create List             a       b       c
    ${dictionary} =         Create Dictionary       a=1     b=2
    EL Should Be True       $[var('domain_name') eq 'domain1']
    EL Should Be True       $[var('string') eq 'some string']
    EL Should Be True       $[var('integer') eq 100]
    EL Should Be True       $[var('boolean')]
    EL Should Be True       $[var('number') eq 42.512]
    EL Should Be True       $[var('list')[0] eq 'a']
    EL Should Be True       $[var('dictionary')['a'] eq '1']

Expression Eval Method
    [Tags]  eval-method
    EL Add Variable         str1        hello
    EL Add Variable         str2        world
    EL Add variable         text        $[concat(eval('$[str1]'), ' ', eval('$[str2]'))]
    EL Should Be Equal      $[text]     hello world

Expression Run Keyword
    [Tags]  run-keyword
    EL Run Keyword      Log Many        $[1]    $[var('domain_name')]
    @{list}=            EL Run Keyword  Create List   $[i:100]       $[i:5]       $[true]
    EL Should Be Equal  $[var('list')[0]]  $[i:100]
    EL Should Be Equal  $[var('list')[1]]  $[i:5]
    EL Should Be True   $[var('list')[2]]
    ${n1}=              Convert To Integer      10
    ${n2}=              Convert To Integer      5
    @{list2} =          Create List             ${n1}       ${n2}       c
    EL Should Be Equal  $[var('list2')[0]]  $[i:10]
    EL Should Be Equal  $[var('list2')[1]]  $[i:5]

Expression replaceVar Method
    [Tags]  replace-var-method
    ${URL}=             Set Variable    http://google.com
    EL Add Variable     x               $[i:1]
    EL Add Variable     y               $[i:2]
    EL Should Be True   $[replaceVars('\${URL}/points/\${x}/\${y}') eq 'http://google.com/points/1/2']

Expression Run Keyword For Each
    [Tags]  run-keyword-for-each
    EL Add Variable     list    $[array:asList(1,2,3)]
    EL Add Variable     excludeIndices    $[array:asList(0)]
    EL Add Variable     ctr               0
    EL Run Keyword For Each  Log Item   item     $[list]
    EL Should Be True  $[ctr eq 2]
    EL Add Variable     ctr               0
    EL Run Keyword For Random  Log Item   10    item     $[list]
    EL Should Be True  $[ctr eq 2]

*** Keywords ***
Log Item
    EL Add Variable     ctr               $[ctr+1]
    EL Run Keyword      Log     $[item]

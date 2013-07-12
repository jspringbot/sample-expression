*** Settings ***
Library     JSpringBotGlobal

*** Test Cases ***
Repeat
    [Tags]      repeat
    ${repeatZero}=      Set Variable    0
    ${repeatThree}=     Set Variable    3
    EL Should Be Equal  $[repeat('x',var('repeatZero'))]        ${EMPTY}
    EL Should Be Equal  $[repeat('y',var('repeatThree'))]       yyy
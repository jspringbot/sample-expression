*** Settings ***
Library     JSpringBotGlobal
Library     Collections

*** Variables ***
@{col1}=    hello   world   good morning     good night
@{col2}=    hello   good morning     good night

*** Test Cases ***
Is Sub Collection
    [Tags]      is-sub-collection
    @{col3}=    Set Variable    1   2   3   4   5
    @{col4}=    Set Variable    5   3   1   7
    ${match1}=  El Evaluate     $[col:isSubCollection(var('col2'), var('col1'))]
    ${match2}=  El Evaluate     $[col:isSubCollection(var('col3'), var('col4'))]
    El Should Be True           $[col:isSubCollection(var('col2'), var('col1'))]
    El Should Be False          $[col:isSubCollection(var('col3'), var('col4'))]

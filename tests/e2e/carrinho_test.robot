language: pt-BR

*** Settings ***
Documentation    Teste híbrido de adicionar produto ao carrinho.

Library          SeleniumLibrary

Resource         ../../resources/configs/api.resource
Resource         ../../resources/configs/qa.resource
Resource         ../../resources/steps/carrinho_steps.resource
Resource         ../../resources/steps/login_steps.resource

Suite Setup      Abrir sessão na API
Suite Teardown   Delete All Sessions
Test Setup       Preparar dados existentes e abrir a loja
Test Teardown    Close All Browsers

Test Tags        e2e    carrinho


*** Test Cases ***
Adicionar produto ao carrinho
    Dado que estou na página inicial da loja
    Quando seleciono um produto
    E adiciono o produto ao carrinho
    E acesso o carrinho de compras
    Então devo validar que o produto está no carrinho via API


*** Keywords ***
Preparar dados existentes e abrir a loja
    ${usuario}=    Buscar usuário válido
    ${produto}=    Buscar produto válido
    Set Test Variable    ${usuario}
    Set Test Variable    ${produto}

    Log To Console    Usuário selecionado: ${usuario}[email]
    Log To Console    Produto selecionado: ${produto}[nome]

    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1440    1200
    Fazer login    ${usuario}[email]    ${usuario}[password]

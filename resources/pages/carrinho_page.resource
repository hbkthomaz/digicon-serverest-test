*** Settings ***
Documentation    Ações da página do carrinho.

Library          SeleniumLibrary
Resource         ../page_objects/carrinho_page_objects.resource


*** Keywords ***
Abrir página inicial da loja
    Wait Until Page Contains Element    ${PRODUTO_ADICIONAR_LISTA}    timeout=15s


Selecionar produto
    Wait Until Page Contains    ${produto}[nome]    timeout=15s
    ${locator}=    Set Variable
    ...    xpath: //div[contains(@class, "card")][.//*[contains(normalize-space(), "${produto}[nome]")]]//button[@data-testid="adicionarNaLista"]
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Click Element    ${locator}


Adicionar produto ao carrinho
    Wait Until Page Contains Element    ${ADICIONAR_CARRINHO}    timeout=10s
    Click Element    ${ADICIONAR_CARRINHO}


Acessar carrinho de compras
    Wait Until Page Contains Element    ${CARRINHO_LINK}    timeout=10s
    Click Element    ${CARRINHO_LINK}
    Wait Until Location Contains    /carrinho    timeout=10s

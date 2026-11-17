language: pt-br

*** Configurações ***
Documentação        Implementação dos Steps da funcionalidade Login.

Biblioteca          SeleniumLibrary
Recurso             ../pages/home_page.resource
Recurso             ../pages/login_page.resource


*** Palavras-Chave ***
que a tela de login do sistema carregou
    Esperar a tela de cadastro carregar


preencho corretamente meus dados de login
    [Arguments]     ${email}       ${senha}

    Preencher campo de e-mail      ${email}
    Preencher campo de senha       ${senha}


submeto o formulário para entrar
    Submeter o formulário de cadastro


Fazer login
    [Arguments]     ${email}    ${senha}

    Wait Until Page Contains Element    ${EMAIL_TEXT_FIELD}    timeout=10s
    Input Text      ${EMAIL_TEXT_FIELD}      ${email}
    Input Password  ${PASSWORD_TEXT_FIELD}   ${senha}
    Click Button    xpath: //button[text() = 'Entrar']
    Wait Until Page Contains Element    xpath: //button[text() = 'Logout']    timeout=10s


devo visualizar a mensagem de erro
    [Arguments]     ${mensagem}
    Wait Until Page Contains           ${mensagem}      timeout=10s


devo visualizar a Serverest Store
    Wait Until Page Contains           Serverest Store  timeout=5s


devo visualizar as opções restritas
    Wait Until Page Contains Element   xpath: //button[text() = 'Logout']
    

não devo mais visualizar a tela de login
    Page Should Not Contain            Login
    Capture Page Screenshot

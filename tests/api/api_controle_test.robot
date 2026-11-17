*** Settings ***
Documentation       Testes de controle da API

Library             SeleniumLibrary

Resource            ../../resources/configs/api.resource
Resource            ../../resources/configs/qa.resource
Resource            ../../resources/steps/login_steps.resource

Suite Setup         Abrir sessão na API
Suite Teardown      Delete All Sessions


*** Test Cases ***
Todos os produtos em estoque têm preço positivo
    [Tags]    api    controle    produtos

    ${resp}=    GET On Session
    ...    serverest
    ...    /produtos
    ...    expected_status=200

    ${produtos}=    Set Variable    ${resp.json()}[produtos]
    ${verificados}=    Set Variable    ${0}

    FOR    ${produto}    IN    @{produtos}

        IF    ${produto}[quantidade] == 0
            CONTINUE
        END

        Should Be True    ${produto}[preco] > 0
        ...    msg=Produto ${produto}[nome] com preço inválido: ${produto}[preco]

        ${verificados}=    Evaluate    ${verificados} + 1
    END

    Log    Produtos em estoque verificados: ${verificados}

    Should Be True
    ...    ${verificados} > 0
    ...    msg=Nenhum produto em estoque disponível foi encontrado

Cadastrar vários produtos com sucesso

    ${headers}=     Criar administrador e obter token
    ${total}=       Set Variable    ${5}
    ${cadastrados}=     Set Variable    ${0}

    FOR     ${i}    IN RANGE    ${total}
        ${produto}=     Gerar produto

        ${resp}=        POST On Session
        ...             serverest
        ...             /produtos
        ...             json=${produto}
        ...             headers=${headers}
        ...             expected_status=201

        Should Not Be Empty     ${resp.json()}[_id]

        ${cadastrados}=     Evaluate        ${cadastrados} + 1

        Log To Console
        ...     Produto ${i+1}/${total} cadastrado com sucesso: ${produto}[nome]

        Sleep       250millisecond
    END

    Should Be Equal As Integers     ${cadastrados}      ${total}


Produto cadastrado pela API aparece para o administrador
    [Tags]    e2e    TC_<id>
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    [Teardown]    Run Keywords
    ...    Excluir E Confirmar Exclusão    ${resp.json()}[_id]    ${headers}
    ...    AND    Close All Browsers

    GROUP    Preparar pela API
        ${usuario}    ${headers}=    Criar Administrador
        ${produto}=    Gerar produto

        ${resp}=    POST On Session
        ...    serverest
        ...    /produtos
        ...    json=${produto}
        ...    headers=${headers}
        ...    expected_status=201
    END

    GROUP    Executar pela interface
        Fazer login    ${usuario}[email]    ${usuario}[password]
        Click Element    css:[data-testid="listarProdutos"]
        Wait Until Page Contains    ${produto}[nome]
    END

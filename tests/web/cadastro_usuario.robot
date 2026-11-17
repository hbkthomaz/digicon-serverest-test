*** Settings ***
Documentation   Criar usuário para realizar o login

Resource        ../../resources/dados.resource


*** Test Cases ***
Realizar Login com dados de usuário gerados automaticamente
    ${usuario}=     Gerar usuário administrador
    Log     ${usuario}

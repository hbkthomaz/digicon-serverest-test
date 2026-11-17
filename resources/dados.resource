*** Settings ***
Library     FakerLibrary    locale=pt_BR
Library     String


*** Keywords ***
Gerar usuário administrador
    ${nome}=        FakerLibrary.Name
    ${login}=       Generate Random String      10      [LOWER]
    ${senha}=       FakerLibrary.Password       length=12
    &{usuario}=     Create Dictionary           nome=${nome}
    ...             email=${login}@academy.dev      password=${senha}
    ...             administrador=true
    RETURN      ${usuario}

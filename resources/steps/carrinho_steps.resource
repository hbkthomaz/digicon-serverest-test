language: pt-BR

*** Settings ***
Documentation    Steps do cenário de adicionar produto ao carrinho.

Resource         ../pages/carrinho_page.resource


*** Keywords ***
que estou na página inicial da loja
    Abrir página inicial da loja


seleciono um produto
    Selecionar produto


adiciono o produto ao carrinho
    Adicionar produto ao carrinho


acesso o carrinho de compras
    Acessar carrinho de compras


devo validar que o produto está no carrinho via API
    Validar produto no carrinho via API    ${usuario}[_id]    ${produto}[_id]

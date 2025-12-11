var database = require("../database/config")

async function novoProduto(idArmazem, precoProduto, saborProduto, qtdProduto) {
    console.log("Ta no model: ", idArmazem, " : ", precoProduto, " : ", saborProduto, " : ", qtdProduto)
    buscaSql = `Select count(idProduto) as qtd from produto where sabor = '${saborProduto}'`
    var existe = await database.executar(buscaSql)
    console.log(existe)
    if (existe[0].qtd == 0) {
        var instrucaoSql = `
        insert into produto (fkArmazem, preco, sabor, qtdProdutos) VALUES
        (${idArmazem}, ${precoProduto}, '${saborProduto}', ${qtdProduto})
        `
    }else{
        var instrucaoSql = `
        update produto set qtdProdutos = qtdProdutos + ${qtdProduto} WHERE sabor = '${saborProduto}'
        `
    }
    console.log(instrucaoSql)
    return database.executar(instrucaoSql)
}

function exibirProduto(idArmazem) {

    // var instrucaoSql = `select sabor as Produto, count(distinct idProduto) as 'Quantidade produto' from produto where fkArmazem = ${idArmazem} group by sabor;`
    var instrucaoSql = `select sabor as Produto, qtdProdutos as 'qtdProduto' from produto where fkArmazem = ${idArmazem};`

    console.log(instrucaoSql)
    return database.executar(instrucaoSql)
}
module.exports = {
    novoProduto,
    exibirProduto
}
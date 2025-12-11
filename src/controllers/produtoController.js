var produtoModel = require("../models/pordutoModel")

function novoProduto(req, res) {
    // idArmazem = req.params.idArmazem;
    var idArmazem = req.body.idArmazemServer
    var precoProduto = req.body.precoProdutoServer
    var saborProduto = req.body.saborProdutoServer
    var qtdProduto = req.body.qtdProdutoServer

    if (idArmazem == undefined) {
        res.status(400).send("Seu id está undefined!");
    }
    produtoModel.novoProduto(idArmazem, precoProduto, saborProduto, qtdProduto).then(function (resposta) {
        res.status(200).send("Produto cadastrado com sucesso");
    }).catch(function (erro) {
        res.status(500).json(erro.sqlMessage);
    })

}


function exibirProduto(req, res) {
    idArmazem = req.params.idArmazem;

    produtoModel.exibirProduto(idArmazem).then(function (resultado) {
        // precisamos informar que o resultado voltará para o front-end como uma resposta em json
        res.status(200).json(resultado);
    }).catch(function (erro) {
        res.status(500).json(erro.sqlMessage);
    })
}
module.exports = {
    novoProduto,
    exibirProduto
}
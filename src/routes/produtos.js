var express = require('express')
var router = express.Router()

var produtosController = require('../controllers/produtoController')

router.post('/novoProduto', function(req, res){
    produtosController.novoProduto(req, res)
})

router.get('/exibirProduto/:idArmazem', function(req, res){
    produtosController.exibirProduto(req, res)

})


module.exports = router;
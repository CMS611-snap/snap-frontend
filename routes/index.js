var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index');
});

/* TODO: Remove when backend components are attached */
router.post('/test', function(req, res) {
  res.send('Sent word: ' + req.body.snap_input);
});

module.exports = router;

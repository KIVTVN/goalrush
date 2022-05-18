const express = require('express');
const router = express.Router();

// TEAM ROUTES
router.get('/:id', require('../controllers/getMatch'));

module.exports = router;

var mysql = require("mysql");

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "qwer5678",
  database: "favorit"
});

module.exports = con;

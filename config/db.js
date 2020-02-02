var mysql = require("mysql");

var con = mysql.createConnection({
  host: "DB_HOST",
  user: "YOUR_DB_USERNAME",
  password: "YOUR_PASSOWRD",
  database: "favorit"
});

module.exports = con;

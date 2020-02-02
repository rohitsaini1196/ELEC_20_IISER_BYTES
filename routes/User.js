var express = require("express");
var router = express.Router();
const db = require("../config/db");

router.get("/", function(req, res) {
  var sql = "SELECT * FROM users";
  db.query(sql, function(err, result, fields) {
    if (err) throw err;
    // console.log(result);
    res.send(result);
  });
});

function getDataByObj(obj, uname) {
  var result = null;
  for (var i = 0; i < obj.length; i++) {
    if (obj[i].email === uname) {
      result = obj[i];
    }
  }

  return result;
}
router.get("/:ggwp", async function(req, res) {
  var sql = "SELECT * FROM users";
  var bakwas = req.params.ggwp;
  console.log(bakwas);

  db.query(sql, function(err, result, fields) {
    if (err) throw err;
    //  console.log(result);

    if (result.length > 0) {
      var expecedUser = getDataByObj(result, bakwas);
      console.log(expecedUser);

      if (expecedUser == null) {
        return res.status(404).send("Not found");
      }
      return res.send(expecedUser);
    } else {
      console.log("bakchodi");
    }

    // console.log(result);
  });
});
router.post("/", function(req, res) {
  var userData = req.body;
  //console.log(userData);
  var values = {
    username: userData.username,
    email: userData.email,
    profileImage: userData.profileImage
  };

  db.query("SELECT * FROM users WHERE email = ?", [userData.email], function(
    err,
    result1,
    fields
  ) {
    console.log(result1);

    if (err) throw err;
    else if (result1.length > 0) {
      return res.send(result1);
    } else {
      var sql = "INSERT INTO users SET ? ";

      db.query(sql, values, function(err, result) {
        if (err) throw err;
        console.log("1 user inserted");
        //  console.log(userData);
        db.query(
          "SELECT * FROM users WHERE email = ?",
          [userData.email],
          function(err, result3, fields) {
            return res.send(result3);
          }
        );
      });
    }
  });
});

//export this router to use in our index.js
module.exports = router;

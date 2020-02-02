const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const db = require("./config/db");
const router = express.Router();

//router
var user = require("./routes/User");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

var garuda = 35;
db.connect(function(err) {
  if (err) throw err;
});

app.use("/users", user);

app.get("/des", (req, res) => {
  var sql = "SELECT * FROM work ORDER BY id_db DESC";
  db.query(sql, function(err, result, fields) {
    if (err) throw err;
    //  console.log(result);
    res.send(result);
  });
});

app.get("/", (req, res) => {
  var sql = "SELECT * FROM work ";
  db.query(sql, function(err, result, fields) {
    if (err) throw err;
    //  console.log(result);
    res.send(result);
  });
});

app.post("/accept", (req, res) => {
  var acceptData = req.body;

  var acceptWorkId = req.body.workId;
  var acceptUserMail = req.body.userMail;
  console.log(acceptWorkId);
  console.log(acceptUserMail);

  var sql = `UPDATE work SET aceepted= 1, id_users_doer = "${acceptUserMail}" WHERE id_db = ${acceptWorkId}`;
  console.log(sql);

  db.query(sql, function(err, result) {
    return res.send("your work accepted!!");
  });
});

app.post("/", (req, res) => {
  var workData = req.body;
  // console.log(workData);
  var values = {
    id_users_giver: workData.giverId,
    work_des: workData.workDes,
    pickup: workData.pickup,
    drop_point: workData.dropPoint,
    garuda: garuda,
    remarks: workData.remarks,
    phone_no: workData.phoneNo
  };
  console.log("Connected!");
  var sql = "INSERT INTO work SET ? ";

  db.query(sql, values, function(err, result) {
    if (err) throw err;
    console.log("1 work inserted");
    // console.log(workData);
    res.status(200).send("success");
  });
});

app.listen(3000, () => console.log("Server live at port 3000"));

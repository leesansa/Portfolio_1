import express from "express";

const app = express();

app.get("/", (req, res) => {
  res.send("express 시작!");
});

app.listen(5000, () => {
  console.log("서버 실행 중 : http://localhost:5000");
});

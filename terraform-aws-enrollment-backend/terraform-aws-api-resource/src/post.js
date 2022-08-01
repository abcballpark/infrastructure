const TABLE_NAME = process.env.TABLE_NAME;
const { create } = require("./dynamodb");

module.exports = (event, context) => {
  const item = JSON.parse(event.body);
  return create(TABLE_NAME, item);
};

const TABLE_NAME = process.env.TABLE_NAME;
const HASH_KEY = process.env.HASH_KEY;
const { putItem } = require("../dynamodb");
const { v4: uuid } = require("uuid");

module.exports = async (event, context) => {
  const item = JSON.parse(event.body);
  const hashkey = uuid();
  item[HASH_KEY] = hashkey;
  console.log(`item: ${JSON.stringify(item)}`);
  try {
    const result = await putItem(item);
    return result;
  } catch (err) {
    console.error(`post error: ${JSON.stringify(err)}`);
    context.fail(err.message);
  }
};

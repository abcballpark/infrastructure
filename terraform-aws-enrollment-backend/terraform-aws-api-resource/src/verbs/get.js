const TABLE_NAME = process.env.TABLE_NAME;
const HASH_KEY = process.env.HASH_KEY;
const { getByKey } = require("../dynamodb");
// const { v4: uuid } = require("uuid");

module.exports = async (event, context) => {
  // Get keys from query params
  const { hashkey, sortkey } = event.queryStringParameters;
  console.log(hashkey, sortkey);

  // Query
  try {
    const result = await getByKey(hashkey, sortkey);
    return result;
  } catch (err) {
    console.error(`${event.httpMethod} error: ${err.message}`);
    context.fail(err.message);
  }
};

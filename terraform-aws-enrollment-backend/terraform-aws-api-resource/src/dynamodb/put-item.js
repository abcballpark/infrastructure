const TABLE_NAME = process.env.TABLE_NAME;
const HASH_KEY = process.env.HASH_KEY;
const SORT_KEY = process.env.SORT_KEY;

const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const { marshall, unmarshall } = require("@aws-sdk/util-dynamodb");
const { getByKey } = require("./get-item");

module.exports = async (item) => {
  const client = new DynamoDBClient({ region: "us-east-1" });

  // Convert to DynamodDB record format
  const record = marshall(item);
  console.log(record);

  // Write to the DB
  const putItemCommand = new PutItemCommand({
    TableName: TABLE_NAME,
    Item: record,
  });
  const putResult = await client.send(putItemCommand);

  // Get the updated item
  const newItem = await getByKey(item[HASH_KEY], item[SORT_KEY]);

  return newItem;
};

const TABLE_NAME = process.env.TABLE_NAME;
const HASH_KEY = process.env.HASH_KEY;
const SORT_KEY = process.env.SORT_KEY;

const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");
const { unmarshall } = require("@aws-sdk/util-dynamodb");

const getByKey = async (hashkey, sortkey) => {
  const client = new DynamoDBClient({ region: "us-east-1" });
  const getItemCommand = new GetItemCommand({
    Key: {
      [HASH_KEY]: { S: hashkey },
      [SORT_KEY]: { S: sortkey },
    },
    TableName: TABLE_NAME,
  });
  const getResult = await client.send(getItemCommand);
  return unmarshall(getResult.Item);
};

module.exports = {
  getByKey,
};

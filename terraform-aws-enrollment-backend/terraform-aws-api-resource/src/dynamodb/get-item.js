const TABLE_NAME = process.env.TABLE_NAME;
const HASH_KEY = process.env.HASH_KEY;
const SORT_KEY = process.env.SORT_KEY;

const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");
const { unmarshall } = require("@aws-sdk/util-dynamodb");

const getByKey = async (hashkey, sortkey) => {
  const client = new DynamoDBClient({ region: "us-east-1" });
  const commandParams = {
    Key: {
      [HASH_KEY]: { S: hashkey },
      [SORT_KEY]: { S: sortkey },
    },
    TableName: TABLE_NAME,
  };
  console.log(`commandParams: ${commandParams}`);
  const getItemCommand = new GetItemCommand(commandParams);
  // console.log(`command: ${JSON.stringify(getItemCommand)}`);
  const getResult = await client.send(getItemCommand);
  return getResult.Item ? unmarshall(getResult.Item) : {};
};

module.exports = {
  getByKey,
};

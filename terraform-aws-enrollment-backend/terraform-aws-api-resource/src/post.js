const { create } = require("./dynamodb")

module.exports = (event, context) => {
    const item = JSON.parse(event.body);
    return create("Participant", item);
}
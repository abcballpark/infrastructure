const post = require("./post");

module.exports.handler = (event, context, callback) => {
  let promise;

  switch (event.httpMethod) {
    case "POST":
      promise = post(event, context);
      break;

    default:
      break;
  }

  promise
    .then((res) => {
      callback(null, {
        body: JSON.stringify(res),
      });
    })
    .catch((err) => {
      callback(err);
    });
};

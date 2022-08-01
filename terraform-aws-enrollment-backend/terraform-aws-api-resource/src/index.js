const post = require("./post");

const respond = (success, result, error, callback) => {
  callback(null, {
    statusCode: success ? 200 : 500,
    body: JSON.stringify({
      success,
      result,
      error,
    }),
  });
};

module.exports.handler = async (event, context, callback) => {
  let result;

  switch (event.httpMethod) {
    case "POST":
      try {
        console.log("POST");
        result = await post(event, context);
        respond(true, result, null, callback);
      } catch (err) {
        console.error(err);
        respond(false, null, err, callback);
      }
    default:
      break;
  }

  // promise
  //   .then((res) => {
  //     callback(null, {
  //       body: JSON.stringify({
  //         success: true,
  //         result: res,
  //         error: null,
  //       }),
  //     });
  //   })
  //   .catch((err) => {
  //     callback(null, {
  //       statusCode: 503,
  //       body: JSON.stringify({
  //         success: false,
  //         result: null,
  //         error: err.message,
  //       }),
  //     });
  //   });
};

const { post, get } = require("./verbs");

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
  let fn;
  switch (event.httpMethod) {
    case "POST":
      fn = post;
      break;
    // try {
    //   console.log(event.httpMethod);
    //   result = await post(event, context);
    //   respond(true, result, null, callback);
    // } catch (err) {
    //   console.error(err);
    //   respond(false, null, err, callback);
    // }
    case "GET":
      fn = get;
      break;
    // try {
    //   console.log(event.httpMethod);
    //   result = get(event, context);
    // } catch (err) {}
    default:
      break;
  }

  try {
    console.log(event.httpMethod);
    result = await fn(event, context);
    respond(true, result, null, callback);
  } catch (err) {
    console.error(err);
    respond(false, null, err, callback);
  }
};

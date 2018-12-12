const AWS = require('aws-sdk');
AWS.config.update({ region: "us-weat-2" });
const rek = new AWS.Rekognition();

const getLabels = async (bucketName, imgName) => {
  const params = {
    Image: {
      S3Object: {
        Bucket: bucketName,
        Name: imgName,
      }
    },
    MaxLabels: 10,
    MinConfidence: 50
  };
  return await rek.detectLabels(params).promise();
}

module.exports = getLabels;

async function test(){
  var d = await getLabels("applestoai", "moon.jpg");
  console.log(d.Labels);
}

// test();
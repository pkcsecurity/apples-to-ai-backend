const AWS = require("aws-sdk");
AWS.config.update({ region: "us-west-2" });
const rek = new AWS.Rekognition();

const getLabels = async (bucketName, imgName) => {
  const params = {
    Image: {
      S3Object: {
        Bucket: bucketName,
        Name: imgName
      }
    },
    MaxLabels: 10,
    MinConfidence: 50
  };
  return await rek.detectLabels(params).promise();
};

async function test(imageName) {
  var d = await getLabels("applestoaisubmissions", imageName);
  console.log(d.Labels);
}

module.exports = { getLabels, test };

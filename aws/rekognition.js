const AWS = require('aws-sdk');
AWS.config.update({region: "us-east-1"});
const rekognition = new AWS.Rekognition();

const getLabels = (bucketName, imgName) => {
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
  rekognition.detectLabels(params, function(err, data){
    if(err) console.log(err);
    else  console.log(data);
  });
}

module.exports = {
  getLabels
}
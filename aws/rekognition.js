const AWS = require('aws-sdk');
const rek = new AWS.Rekognition();

function getLabels(bucketName, imgName){
  var params = {
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
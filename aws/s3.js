const AWS = require('aws-sdk');
AWS.config.update({region: "us-east-1"});
const s3 = new AWS.S3();

const uploadImage = (bucketName, imgName, img) => {
  const params = {Bucket: bucketName, Key: imgName, Body: img};
  s3.putObject(imgObj, function(err, data){
    if(err) console.log(err);
    else console.log("Successfully uploaded " + imgName + " to " + bucketName);
  });
}

const getImage = (bucketName, imgName) => {
  const params = {Bucket: bucketName, Key: imgName};
  s3.getObject(params, function(err, data){
   if(err) console.log(err);
   else console.log(data);           
 });
}

const getImgsOfBucket = (bucketName) => {
  const params = {Bucket: bucketName};
  s3.listObjects(params, function(err, data){
    if(err)  console.log(err);
    else  console.log(data);
  });
}

module.exports = {
  uploadImage,
  getImage,
  getImgsOfBucket
}
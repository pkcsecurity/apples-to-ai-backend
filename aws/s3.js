const AWS = require('aws-sdk');
const s3 = new AWS.S3();

function uploadImage(bucketName, imgName, img){
  var params = {Bucket: bucketName, Key: imgName, Body: img};
  s3.putObject(imgObj, function(err, data){
    if(err) console.log(err);
    else console.log("Successfully uploaded " + imgName + " to " + bucketName);
  });
}

function getImage(bucketName, imgName){
  var params = {Bucket: bucketName, Key: imgName};
  s3.getObject(params, function(err, data){
   if(err) console.log(err);
   else console.log(data);           
 });
}

function getImgsOfBucket(bucketName){
  var params = {Bucket: bucketName};
  s3.listObjects(params, function(err, data){
    if(err)  console.log(err);
    else  console.log(data);
  });
}


const AWS = require('aws-sdk');
AWS.config.update({region: "us-east-1"});
const s3 = new AWS.S3();
const fs = require('fs');
const path = require("path");

const uploadImage = async (bucketName, imgName, img) => {
  const params = {Bucket: bucketName, Key: imgName, Body: img};
  return await s3.putObject().promise();
}

const getImage = async (bucketName, imgName) => {
  const params = {Bucket: bucketName, Key: imgName};
  return await s3.getObject(params).promise();
}

const getImgsOfBucket = async (bucketName) => {
  const params = {Bucket: bucketName};
  return await s3.listObjects(params).promise();
}

module.exports = {
  uploadImage,
  getImage,
  getImgsOfBucket
}


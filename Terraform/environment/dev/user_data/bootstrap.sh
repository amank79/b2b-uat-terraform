#!/bin/bash

yum update -y
yum install nginx -y
service nginx start
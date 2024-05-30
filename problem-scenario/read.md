```
Scenario: Multi-Region Deployment with Conditional Resource Creation

You are working as a cloud infrastructure engineer and need to deploy a set of resources across multiple AWS regions. However, there are specific requirements for different regions:

In the us-east-1 region, you need to create an EC2 instance and attach a security group that allows HTTP and SSH traffic.
In the us-west-2 region, you only need to create an S3 bucket for storing logs, and no EC2 instance should be created.
The EC2 instance type should be t2.micro if the environment is dev and t3.micro if the environment is prod.

```

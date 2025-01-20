# SQS
**S**imple **Q**ueue **S**ervice is a managed message queuing service technical professionals and developers use to send, store and retrieve multiple messages of various sizes asynchronously.

## Serverless
*парадигма, в которой разрабам не надо больше менеджить серваки или **FaaS** (Function as a Service):
- SNS & **SQS**

У **Lambda** есть возможность интеграции с **SQS** для обработки сообщений из очередей.

:::info
Amazon **SQS** allows you to retain messages for days and process them later, while we can take down our EC2 instances.
:::
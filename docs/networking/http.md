---
sidebar_position: 3
---
# HTTP
https://developer.mozilla.org/en-US/docs/Web/HTTP/

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## HTTP response status codes
<Tabs>
  <TabItem value="1xx" label="Informational 1xx" default>
    <p><b>100 Continue</b></p>
    <p><b>101 Switching Protocols</b></p>
    <p><b>102 Processing</b></p>
    <p><b>103 Early Hints</b></p>
  </TabItem>
  <TabItem value="2xx" label="Successful 2xx">
    <p><b>200 OK</b></p>
    <p><b>201 Created</b></p>
    <p><b>202 Accepted</b></p>
    <p><b>203 Non-Authoritative Information</b></p>
    <p><b>204 No Content</b></p>
    <p><b>205 Reset Content</b></p>
    <p><b>206 Partial Content</b></p>
    <p><b>207 Multi-Status</b></p>
    <p><b>208 Already Reported</b></p>
    <p><b>226 IM Used</b></p>
  </TabItem>
  <TabItem value="3xx" label="Redirection 3xx">
    <p><b>300 Multiple Choices</b></p>
    <p><b>301 Moved Permanently</b></p>
    <p><b>302 Found</b></p>
    <p><b>303 See Other</b></p>
    <p><b>304 Not Modified</b></p>
    <p><b>305 Use Proxy</b></p>
    <p><b>306 unused</b></p>
    <p><b>307 Temporary Redirect</b></p>
    <p><b>308 Permanent Redirect</b></p>
  </TabItem>
  <TabItem value="4xx" label="Client 4xx">
    <p><b>400 Bad Request</b></p>
    <p><b>401 Unauthorized</b></p>
    <p><b>402 Payment Required</b></p>
    <p><b>403 Forbidden</b>: когда нет доступа на ресурс</p>
    <p><b>404 Not Found</b></p>
    <p><b>405 Method Not Allowed</b></p>
    <p><b>406 Not Acceptable</b></p>
    <p><b>407 Proxy Authentication Required</b></p>
    <p><b>408 Request Timeout</b></p>
    <p><b>409 Conflict</b></p>
    <p><b>410 Gone</b></p>
    <p><b>411 Length Required</b></p>
    <p><b>412 Precondition Failed</b></p>
    <p><b>413 Payload Too Large</b></p>
    <p><b>414 URI Too Long</b></p>
    <p><b>415 Unsupported Media Type</b></p>
    <p><b>416 Range Not Satisfiable</b></p>
    <p><b>417 Expectation Failed</b></p>
    <p><b>418 I'm a teapot</b></p>
    <p><b>421 Misdirected Request</b></p>
    <p><b>422 Unprocessable Content</b></p>
    <p><b>423 Locked</b></p>
    <p><b>424 Failed Dependency</b></p>
    <p><b>425 Too Early</b></p>
    <p><b>426 Upgrade Required</b></p>
    <p><b>428 Precondition Required</b></p>
    <p><b>429 Too Many Requests</b>: когда на фаерволле установлены рейт лимит правила и мы их нарушаем</p>
    <p><b>431 Request Header Fields Too Large</b></p>
    <p><b>449 Retry With</b></p>
    <p><b>451 Unavailable For Legal Reasons</b></p>
    <p><b>499 Client Closed Request</b></p>
  </TabItem>
  <TabItem value="5xx" label="Server 5xx">
    <p><b>500 Internal Server Error</b></p>
    <p><b>501 Not Implemented</b></p>
    <p><b>502 Bad Gateway</b></p>
    <p><b>503 Service Unavailable</b></p>
    <p><b>504 Gateway Timeout</b></p>
    <p><b>505 HTTP Version Not Supported</b></p>
    <p><b>506 Variant Also Negotiates</b></p>
    <p><b>507 Insufficient Storage</b></p>
    <p><b>508 Loop Detected</b></p>
    <p><b>509 Bandwidth Limit Exceeded</b></p>
    <p><b>510 Not Extended</b></p>
    <p><b>511 Network Authentication Required</b></p>
    <p><b>520 Unknown Error</b></p>
    <p><b>521 Web Server Is Down</b></p>
    <p><b>522 Connection Timed Out</b></p>
    <p><b>523 Origin Is Unreachable</b></p>
    <p><b>524 A Timeout Occurred</b></p>
    <p><b>525 SSL Handshake Failed</b></p>
    <p><b>526 Invalid SSL Certificate</b></p>
  </TabItem>
</Tabs>

## HTTP Methods
GET
POST
PUT
HEAD

## HTTP Headers

## CORS
**Cross-Origin Resource Sharing** — это механизм на основе `HTTP Header`, который позволяет серверу указывать любые источники (домен, схему или порт), отличные от его собственного, из которых браузер должен разрешать загрузку ресурсов. 

**CORS** определяет для клиентских веб-приложений, загруженных в одном домене, способ взаимодействия с ресурсами в другом домене. Это полезно, поскольку сложные приложения часто ссылаются на сторонние API и ресурсы в своем клиентском коде. Например, ваше приложение может использовать браузер для извлечения видео из API видеоплатформы, использования шрифтов из общедоступной библиотеки шрифтов или отображения данных о погоде из национальной базы данных погоды - `Host: www.other.com` (Cross-Origin), `Origin: https://www.example.com` (origin).

**CORS** позволяет браузеру клиента проверять на сторонних серверах, авторизован ли запрос перед передачей данных. Чтобы не было никаких проблем с загрузкой объектов из сторонних мест - надо прописать разрешающий `CORS Header` - `Access-Control-Allow-Origin`.

## Cookie

## Cache
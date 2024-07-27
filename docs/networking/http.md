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
### GET
Цель: Получить данные с сервера.
> Несколько идентичных запросов должны иметь тот же эффект, что и один запрос. Не изменяет состояние сервера (только чтение). Ответы могут кэшироваться браузерами и посредниками.
```bash
GET /api/users/123
```
> Этот запрос возвращает пользователя с идентификатором 123.

### POST
Цель: Отправить данные для обработки на сервер.
> Несколько одинаковых запросов могут иметь разные эффекты (например, создание нескольких ресурсов). Можно изменить состояние сервера (создать, обновить, удалить), что небезопасно. Как правило, ответы не кэшируются.
```bash
POST /api/users
Content-Type: application/json

{
    "name": "John Doe",
    "email": "john.doe@example.com"
}
```
> Этот запрос создает нового пользователя с указанным именем и адресом электронной почты.

### PUT
Цель: Обновить или создать ресурс по указанному URI.
> Несколько идентичных запросов должны иметь тот же эффект, что и один запрос. Может изменить состояние сервера. Ответы обычно не кэшируются.
```bash
PUT /api/users/123
Content-Type: application/json

{
    "name": "Jane Doe",
    "email": "jane.doe@example.com"
}
```
> Этот запрос сообщает пользователю с идентификатором 123 новое имя и адрес электронной почты. Если пользователь не существует, он может создать нового пользователя с этим идентификатором.

### DELETE
Цель: Удалить ресурс с сервера.
> Несколько одинаковых запросов должны иметь тот же эффект, что и один запрос. Может изменить состояние сервера. Ответы обычно не кэшируются.
```bash
DELETE /api/users/123
```
> Этот запрос удаляет пользователя с идентификатором 123.

### HEAD
Цель: Получить заголовки ресурса.
> Несколько одинаковых запросов должны иметь тот же эффект, что и один запрос. Не изменяет состояние сервера. Ответы могут кэшироваться браузерами и посредниками.
```bash
HEAD /api/users/123
```
> Этот запрос получает заголовки пользовательского ресурса с идентификатором 123 без фактического содержимого тела.

## HTTP Headers
Заголовки HTTP — это пары ключ-значение, передаваемые между клиентом и сервером в HTTP-запросах и ответах. Они предоставляют важную информацию о запросе или ответе, клиенте, сервере и передаваемых данных.
### Request Headers
Предоставить информацию о запросе клиента.
```bash
GET /index.html HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
```

### Response Headers
Предоставьте информацию об ответе сервера.
```bash
HTTP/1.1 200 OK
Date: Wed, 21 Jul 2021 07:28:00 GMT
Server: Apache/2.4.41 (Ubuntu)
Last-Modified: Mon, 21 Jul 2021 07:28:00 GMT
Content-Type: text/html
Content-Length: 174
Connection: keep-alive

<!DOCTYPE html>
<html>
<head>
    <title>Example Page</title>
</head>
<body>
    <h1>Hello, World!</h1>
</body>
</html>
```

### General Headers
Применимо как к запросам, так и к ответам.
```bash
HTTP/1.1 200 OK
Date: Wed, 21 Jul 2021 07:28:00 GMT
Connection: keep-alive
Cache-Control: no-cache
```

### Entity Headers
Предоставляет информацию о теле ресурса.
```bash
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 348
Content-Encoding: gzip
Content-Language: en-US
Content-Location: /documents/123
```

## CORS
**Cross-Origin Resource Sharing** — это механизм на основе `HTTP Header`, который позволяет серверу указывать любые источники (домен, схему или порт), отличные от его собственного, из которых браузер должен разрешать загрузку ресурсов. 

**CORS** определяет для клиентских веб-приложений, загруженных в одном домене, способ взаимодействия с ресурсами в другом домене. Это полезно, поскольку сложные приложения часто ссылаются на сторонние API и ресурсы в своем клиентском коде. Например, ваше приложение может использовать браузер для извлечения видео из API видеоплатформы, использования шрифтов из общедоступной библиотеки шрифтов или отображения данных о погоде из национальной базы данных погоды - `Host: www.other.com` (Cross-Origin), `Origin: https://www.example.com` (origin).

**CORS** позволяет браузеру клиента проверять на сторонних серверах, авторизован ли запрос перед передачей данных. Чтобы не было никаких проблем с загрузкой объектов из сторонних мест - надо прописать разрешающий `CORS Header` - `Access-Control-Allow-Origin`.

## Cookie
Cookie — это небольшие фрагменты данных, которые веб-браузер сохраняет на компьютере пользователя во время просмотра веб-сайта. Они используются для запоминания информации о пользователе и его действиях в разных сеансах.

### Types of Cookies
- **Session Cookies**: временные Cookie, которые удаляются при закрытии браузера.
- **Persistent Cookies**: Cookie, которые остаются на устройстве пользователя в течение определенного периода или до тех пор, пока не будут удалены.
- **Secure Cookies**: передаются только через безопасные соединения HTTPS.
- **HttpOnly Cookies**: недоступны через JavaScript, что снижает риск XSS-атак.

### Common Uses
- Управление сеансом: статус входа пользователя, содержимое корзины покупок, результаты игр или любые другие сведения, связанные с сеансом пользователя, которые сервер должен запомнить.
- Персонализация: пользовательские настройки, такие как язык отображения и тема пользовательского интерфейса.
- Отслеживание: запись и анализ поведения пользователей.

## Cache
Кэш — это процесс хранения копий файлов или данных во временном хранилище (кеше) для обеспечения более быстрого доступа. Кэширование повышает производительность за счет сокращения времени, необходимого для получения данных и нагрузки на сервер.

### Types of Cache
- Memory Cache: Быстрое энергозависимое хранилище, используемое для временного хранения данных.
- Disk Cache: Медленнее, чем кеш-память, но обеспечивает постоянное хранилище.
- Proxy Cache: Промежуточный кеш, который хранит данные для нескольких пользователей и снижает использование полосы пропускания.

### Storage Locations
- Browser Cache: Хранит копии веб-страниц, изображений и других ресурсов на устройстве пользователя.
- Server Cache: Кэширует ответы на стороне сервера для быстрого обслуживания последующих запросов.
- CDN Cache: CDN кэшируют контент в различных местах по всему миру, чтобы уменьшить задержку и сократить время загрузки для пользователей по всему миру.

## HTTP vs. HTTPS
<Tabs>
  <TabItem value="1" label="Security" default>
    <p><b>HTTP</b>: HTTP небезопасен. Данные, отправляемые по протоколу HTTP, не зашифрованы и могут быть перехвачены злоумышленниками. Данные - это логин, персональная информация, история браузера, сессии. Перехватываются эти данные разными способами, например аттака <b>MITM</b> (<i>Man-in-the-Middle Attack</i>)</p>
    <p><b>HTTPS</b>: HTTPS безопасен. Он использует SSL/TLS для шифрования данных между браузером пользователя и сервером, защищая их от перехвата.</p>
  </TabItem>
  <TabItem value="2" label="Port Number">
    <p><b>HTTP</b>: 80</p>
    <p><b>HTTPS</b>: 443</p>
  </TabItem>
  <TabItem value="3" label="Data Integrity" default>
    <p><b>HTTP</b>: Данные могут быть изменены или повреждены во время передачи без обнаружения.</p>
    <p><b>HTTPS</b>: Обеспечивает целостность данных, проверяя, что данные не были изменены во время передачи.</p>
  </TabItem>
  <TabItem value="4" label="Authentication">
    <p><b>HTTP</b>: Не обеспечивает никакой проверки личности сервера.</p>
    <p><b>HTTPS</b>: Использует сертификаты SSL/TLS для проверки подлинности сервера, гарантируя, что пользователь взаимодействует с предполагаемым веб-сайтом.</p>
  </TabItem>
  <TabItem value="5" label="SEO and Browser Behavior" default>
    <p><b>HTTP</b>: Веб-сайты, использующие HTTP, могут быть помечены браузерами как «небезопасные». Они также могут иметь более низкий рейтинг в результатах поисковых систем.</p>
    <p><b>HTTPS</b>: Веб-сайты, использующие HTTPS, помечаются как безопасные и могут повысить рейтинг в результатах поисковых систем. Современные браузеры также предпочитают, а иногда даже требуют HTTPS для определенных функций.</p>
  </TabItem>
  <TabItem value="6" label="Use Cases">
    <p><b>HTTP</b>: Подходит для неконфиденциальной информации, безопасность которой не имеет значения, например общедоступных веб-сайтов и блогов.</p>
    <p><b>HTTPS</b>: Необходим для конфиденциальной информации, такой как страницы входа, платежные транзакции и любой сайт, требующий пользовательских данных.</p>
  </TabItem>
</Tabs>
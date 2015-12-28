# node-paycoin
[![travis][travis-image]][travis-url]
[![npm][npm-image]][npm-url]
[![downloads][downloads-image]][downloads-url]
[![js-standard-style][standard-image]][standard-url]

node-paycoin is a simple wrapper for the Paycoin client's JSON-RPC API. This is a fork from node-bitcoin - credits to them please.

The API is equivalent to the API document.
The methods are exposed as lower camelcase methods on the `paycoin.Client`
object, or you may call the API directly using the `cmd` method.

This module uses callbacks, which is the prevalent way to work with asynchronous functions in Node.js. If you'd like to instead use promises, then please see the [paycoin-promise](https://github.com/rcorbish/node-paycoin-promise) module.

## Install

`npm install paycoin`

## Examples

### Create client
```js
// all config options are optional
var client = new paycoin.Client({
  host: 'localhost',
  port: 8332,
  user: 'username',
  pass: 'password',
  timeout: 30000
});
```

### Get balance across all accounts with minimum confirmations of 6

```js
client.getBalance('*', 6, function(err, balance, resHeaders) {
  if (err) return console.log(err);
  console.log('Balance:', balance);
});
```
### Getting the balance directly using `cmd`

```js
client.cmd('getbalance', '*', 6, function(err, balance, resHeaders){
  if (err) return console.log(err);
  console.log('Balance:', balance);
});
```

### Batch multiple RPC calls into single HTTP request

```js
var batch = [];
for (var i = 0; i < 10; ++i) {
  batch.push({
    method: 'getnewaddress',
    params: ['myaccount']
  });
}
client.cmd(batch, function(err, address, resHeaders) {
  if (err) return console.log(err);
  console.log('Address:', address);
});
```

## SSL
See [Enabling SSL on original client](https://en.paycoin.it/wiki/Enabling_SSL_on_original_client_daemon).

If you're using this to connect to paycoind across a network it is highly
recommended to enable `ssl`, otherwise an attacker may intercept your RPC credentials
resulting in theft of your paycoins.

When enabling `ssl` by setting the configuration option to `true`, the `sslStrict`
option (verifies the server certificate) will also be enabled by default. It is
highly recommended to specify the `sslCa` as well, even if your paycoind has
a certificate signed by an actual CA, to ensure you are connecting
to your own paycoind.

```js
var client = new paycoin.Client({
  host: 'localhost',
  port: 8332,
  user: 'username',
  pass: 'password',
  ssl: true,
  sslStrict: true,
  sslCa: fs.readFileSync(__dirname + '/myca.cert')
});
```

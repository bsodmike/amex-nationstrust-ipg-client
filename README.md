## amex-nationstrust-ipg-client

### Credit

Created by [Michael de Silva](http://desilva.io/) and now released into the wild.

### Real World Use

In actual use, I would add `keys/my*` to the `.gitignore` file before setting up a production ready copy of this codebase.

You will find notes in each of the files listed in `keys/` with instructions.

This setup was last deployed and tested on production from January - February 2017.

### Generate Private Keys

These need to be sent to NTB to be added to the account first!  They are pretty slow going about this.
If you plan to manage credentials for both a Live and Test environment, this will be painful.

```
java -cp
"ibmjceprovider.jar:ibmpkcs.jar:ipgclient2.jar:jce1_2_1.jar:KeyGenApp.jar:local_policy.jar:log4j-1.2.15.jar:sunjce_provider.jar:US_export_policy.jar"
keygenapp.KeyGen
```

The `ipgpubkey.txt` file needs to be downloaded from the respective portal.

* Live portal: https://www.ipayamex.lk/ipg/index2.html
* Test portal: https://test.ipayamex.lk/ipg/index2.html

Configure the app to use the correct payment endpoint and `MID`

```
# Live Server URL
AMEX_NATIONSTRUST_IPG_SERVER_URL  =   https://www.ipayamex.lk/ipg/servlet_pay

# Test Server URL
AMEX_NATIONSTRUST_IPG_SERVER_URL  =   https://test.ipayamex.lk/ipg/servlet_pay
```

Example config (for local dev) [using `dotenv`](https://www.npmjs.com/package/dotenv)

```
AMEX_NATIONSTRUST_IPG_MERCHANT_ID =   TESTMID
AMEX_NATIONSTRUST_IPG_HOST        =   // point at your test app instance
AMEX_NATIONSTRUST_IPG_PORT        =   9000
AMEX_NATIONSTRUST_IPG_SERVER_URL  =   https://test.ipayamex.lk/ipg/servlet_pay

AMEX_NATIONSTRUST_IPG_MERCHANT_ID =   LIVEMID
AMEX_NATIONSTRUST_IPG_HOST        =   // point at your live app instance
AMEX_NATIONSTRUST_IPG_PORT        =   9000
AMEX_NATIONSTRUST_IPG_SERVER_URL  =   https://www.ipayamex.lk/ipg/servlet_pay
```

### Run JAR

Run `/StartService.sh` passing path to `keyfiles`, `logpath`, and specify `port`.

```
./StartService.sh -keypath/home/ubuntu/sym-amex-nationstrust-ipg-client/keys/ -logpath/home/ubuntu/amex-nationstrust-ipg-client/log/ -port9000&
```

### License

This is released under the MIT license. See the [LICENSE file](LICENSE) for details.

### Disclosure

I am in no way associated or affiliated with Nations Trust Bank (NTB), Sri Lanka.  This code is provided to aid anyone looking to get their IPG Client up and running quickly in a Docker container.

If you experience any issues, please contact NTB directly.

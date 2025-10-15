+++
title = "How I Stopped Yelling at My Pi Pico and Got HTTPS Working"
date = "2025-10-14"
author = "Vivek Ranjan"
tags = ["circuitpython", "raspberry pi pico w"]
keywords = ["circuitpython", "raspberry pi pico w", "http", "https", "networking"]
categories = ["Guides", "Microcontrollers"]
showFullContent = false
readingTime = true
+++

Recently I have been working with the Raspberry Pi Pico W and I wanted to hit multiple HTTP endpoints, hosted on
different domains.

I didn’t think this would be a problem at all. I mean, we live in a world of browsers and cloud servers that Just Handle It™.

But CircuitPython had other plans.


## Why?

Apparently, when you have a tiny bit of memory you can't have in-built support for a lot of certificates out of the box.
The authors of CircuitPython have a few certificates included in their builds [here](https://github.com/adafruit/certificates),
but if your endpoint uses a certificate chain that isn’t in that list… you’re out of luck.

## Solution

This [post](https://lenp.net/dev/cp-ssl-certs) by Len Popp pointed me in the right direction, but it only covers adding one custom certificate.

My project needed to hit multiple domains — one of which wasn’t covered by the default CA list.

So I had to maintain two SSL contexts:

1. one default (using the built-in certs)
2. one custom (with my extra CA)

```python
import ssl
from wifi import radio
from adafruit_connection_manager import get_radio_socketpool, get_radio_ssl_context


# Default context (no extra CA modifications)
ssl_context_default = get_radio_ssl_context(radio)

# context (with custom CA)
ssl_custom_context = ssl.create_default_context()

# See section below for how to get the certificate
ssl_cert = '''
-----BEGIN CERTIFICATE-----\n
MIIDejCCAmKgAwIBAgIQf+UwvzMTQ77dghYQST2KGzANBgkqhkiG9w0BAQsFADBX\n
MQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UE\n
CxMHUm9vdCBDQTEbMBkGA1UEAxMSR2xvYmFsU2lnbiBSb290IENBMB4XDTIzMTEx\n
NTAzNDMyMVoXDTI4MDEyODAwMDA0MlowRzELMAkGA1UEBhMCVVMxIjAgBgNVBAoT\n
GUdvb2dsZSBUcnVzdCBTZXJ2aWNlcyBMTEMxFDASBgNVBAMTC0dUUyBSb290IFI0\n
MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE83Rzp2iLYK5DuDXFgTB7S0md+8Fhzube\n
Rr1r1WEYNa5A3XP3iZEwWus87oV8okB2O6nGuEfYKueSkWpz6bFyOZ8pn6KY019e\n
WIZlD6GEZQbR3IvJx3PIjGov5cSr0R2Ko4H/MIH8MA4GA1UdDwEB/wQEAwIBhjAd\n
BgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDwYDVR0TAQH/BAUwAwEB/zAd\n
BgNVHQ4EFgQUgEzW63T/STaj1dj8tT7FavCUHYwwHwYDVR0jBBgwFoAUYHtmGkUN\n
l8qJUC99BM00qP/8/UswNgYIKwYBBQUHAQEEKjAoMCYGCCsGAQUFBzAChhpodHRw\n
Oi8vaS5wa2kuZ29vZy9nc3IxLmNydDAtBgNVHR8EJjAkMCKgIKAehhxodHRwOi8v\n
Yy5wa2kuZ29vZy9yL2dzcjEuY3JsMBMGA1UdIAQMMAowCAYGZ4EMAQIBMA0GCSqG\n
SIb3DQEBCwUAA4IBAQAYQrsPBtYDh5bjP2OBDwmkoWhIDDkic574y04tfzHpn+cJ\n
odI2D4SseesQ6bDrarZ7C30ddLibZatoKiws3UL9xnELz4ct92vID24FfVbiI1hY\n
+SW6FoVHkNeWIP0GCbaM4C6uVdF5dTUsMVs/ZbzNnIdCp5Gxmx5ejvEau8otR/Cs\n
kGN+hr/W5GvT1tMBjgWKZ1i4//emhA1JG1BbPzoLJQvyEotc03lXjTaCzv8mEbep\n
8RqZ7a2CPsgRbuvTPBwcOMBBmuFeU88+FSBX6+7iP0il8b4Z0QFqIwwMHfs/L6K1\n
vepuoxtGzi4CZ68zJpiq1UvSqTbFJjtbD4seiMHl\n
-----END CERTIFICATE-----\n
'''
ssl_custom_context.load_verify_locations(cadata=ssl_cert)
```

Then, create sessions with these contexts as needed:
```python
from adafruit_requests import Session
from adafruit_connection_manager import get_radio_socketpool

pool = get_radio_socketpool(radio)
default_ssl_session = Session(pool, ssl_context_default)
custom_cert_ssl_ssesion = Session(pool, ssl_custom_context)
```

### Retrieving the certificate

I wanted to make it easy to retrieve the certificate for a given domain, so I wrote a small script to do that.
You can find the script [here](https://gist.github.com/bcosynot/7b880c811682a9ebb02a81e6fb3a0077)


## Wrap-up

CircuitPython’s SSL support is intentionally minimal. Which is fair when you’re running on something the size of a
postage stamp.

If you only need one extra cert, this trick will save you a lot of head-banging.
If you need more than that… maybe reconsider your architecture (or your life choices).

import json
from urllib.request import Request, urlopen
import uuid
import hmac
import hashlib


#parameters send to MoMo get get payUrl
endpoint = "https://test-payment.momo.vn/gw_payment/transactionProcessor"
partnerCode = "MOMOG34Y20211031"
accessKey = "2Iqsp6o63HTK16O6"
secretKey = "ePqwvSav8J3kBGlJPk7QjWcQUONrE6fw"
orderInfo = "pay with MoMo"
redirectUrl = "https://google.com"
ipnUrl = "https://google.com"
amount = "50000"
orderId = str(uuid.uuid4())
requestId = str(uuid.uuid4())
requestType = "captureWallet"
extraData = "" #pass empty value or Encode base64 JsonString

#before sign HMAC SHA256 with format: accessKey=$accessKey&amount=$amount&extraData=$extraData&ipnUrl=$ipnUrl&orderId=$orderId&orderInfo=$orderInfo&partnerCode=$partnerCode&redirectUrl=$redirectUrl&requestId=$requestId&requestType=$requestType
rawSignature = "accessKey="+accessKey+"&amount="+amount+"&extraData="+extraData+"&ipnUrl="+ipnUrl+"&orderId="+orderId+"&orderInfo="+orderInfo+"&partnerCode="+partnerCode+"&redirectUrl="+redirectUrl+"&requestId="+requestId+"&requestType="+requestType

#puts raw signature
print ("--------------------RAW SIGNATURE----------------")
print (rawSignature)
#signature
h = hmac.new( bytes(secretKey), rawSignature, hashlib.sha256 )
signature = h.hexdigest()
print ("--------------------SIGNATURE----------------")
print (signature)

#json object send to MoMo endpoint

data = {
        'partnerCode' : partnerCode,
      	'partnerName' : "Test",
      	'storeId' : "MomoTestStore",
      	'requestId' : requestId,
      	'amount' : amount,
      	'orderId' : orderId,
      	'orderInfo' : orderInfo,
      	'redirectUrl' : redirectUrl,
      	'ipnUrl' : ipnUrl,
      	'lang' : "vi",
      	'extraData' : extraData,
      	'requestType' : requestType,
      	'signature' : signature
}
print ("--------------------JSON REQUEST----------------\n")
data = json.dumps(data)
print (data)

clen = len(data)
req = Request(endpoint, data, {'Content-Type': 'application/json', 'Content-Length': clen})
f = urlopen(req)

response = f.read()
f.close()
print ("--------------------JSON response----------------\n")
print (response+"\n")

print ("payUrl\n")
print (json.loads(response)['payUrl']+"\n")


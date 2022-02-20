import hashlib
import hmac

from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_v1_5 as Cipher_PKCS1_v1_5
from base64 import b64encode
import json

def create_hash_by_RSA(rowData={}):
    amount = rowData.get('amount')
    storeSlug = rowData.get('storeSlug')
    billId = rowData.get('billId')

    if not (amount and billId and storeSlug):
        return
    base_path = r'/'
    f = open(base_path + '/abaManageShip/mykey.pem', 'r')
    key = RSA.importKey(f.read())

    cipher = Cipher_PKCS1_v1_5.new(key)
    cipher_text = cipher.encrypt(json.dumps(rowData).encode())
    return b64encode(cipher_text)

def create_signature(storeSlug, amount, orderId):
    key = b"C1W3HTLZRD5wKsWJSwuAA6PLUbs4MhqE"
    raw_signature = bytes("storeSlug={0}&amount={1}&billId={2}".format(storeSlug, amount, orderId), encoding='utf8')
    return hmac.new(key, raw_signature, hashlib.sha256).hexdigest()
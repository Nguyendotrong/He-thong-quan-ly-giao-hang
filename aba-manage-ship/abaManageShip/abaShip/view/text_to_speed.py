import requests

url = 'https://api.fpt.ai/hmi/tts/v5'

payload = '''Hé lô mọi người. Hôm nay mình mời mọi người
 tham quan về dự án chuyển dời địa điểm, cho một cửa hàng đồ chơi trẻ em,
  và đồ dùng học tập. Hiện tại là mình đang có mặt tại địa điểm mới của cửa hàng.
   Các anh nhân viên đang sắp xếp hàng hóa lên kệ, cho cửa hàng. 
   Chị quản lý sẽ hướng dẫn các anh vị trí sắp xếp. Cửa hàng khá là rộng
    đồ đạc chủ yếu đồ chơi, nên công việc khá nhẹ nhàng,
     nhưng bù lại thì công việc nhỏ nhỏ khá nhiều, 
     cần số lượng lớn nhân viên phụ cửa hàng xếp đồ.

'''
headers = {
    'api-key': 'IisBETpBWpBRqjq9qdyrc7W7aOtbq592',
    'speed': '1.35',
    'voice': 'minhquang'
}

response = requests.request('POST', url, data=payload.encode('utf-8'), headers=headers)

print(response.text)

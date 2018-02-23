# 大文件如果一次性读入计算，会占用大量内存，可以分块读取、分块计算，效果与一次读取计算相同。代码如下：
# paste from https://segmentfault.com/a/1190000002978881 on 24/02/2018
import hashlib
import base64

'''
sha1 file with filename (SHA1)
'''
def SHA1FileWithName(fineName, block_size=64 * 1024):
  with open(fineName, 'rb') as f:
    sha1 = hashlib.sha1()
    while True:
      data = f.read(block_size)
      if not data:
        break
      sha1.update(data)
    retsha1 = base64.b64encode(sha1.digest())
    return retsha1

'''
md5 file with filename (MD5)
'''
def MD5FileWithName(fineName, block_size=64 * 1024):
  with open(fineName, 'rb') as f:
    md5 = hashlib.md5()
    while True:
      data = f.read(block_size)
      if not data:
        break
      md5.update(data)
    retmd5 = base64.b64encode(md5.digest())
    return retmd5

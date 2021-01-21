a=0
def speak(text):
  global a
  a+=1
  return text+"\n "+str(a)+" click"

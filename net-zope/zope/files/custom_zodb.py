import ZEO.ClientStorage, os, string     

host=os.environ.get('ZEO_SERVER_NAME', '')
port=string.atoi(os.environ['ZEO_SERVER_PORT'])    

Storage=ZEO.ClientStorage.ClientStorage(
        (host, port), name='ZEO Demo')

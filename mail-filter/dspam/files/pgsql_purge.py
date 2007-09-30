#!/bin/env python

import sys, os
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def main():
    if len(sys.argv) == 5:
        thiscript, serverhost, serverport, dspamdb, purgescript = sys.argv
    else:
        print "Usage: %s server_host server_port dspam_dbname purge_script" %(sys.argv[0])
        sys.exit(1)
    try:
        env = os.environ
        dspamuser = env['PGUSER']
        dspampass = env['PGPASSWORD']
        if len(serverport) > 0:
            con = psycopg2.connect(host=serverhost, port=int(serverport), database=dspamdb, user=dspamuser, password=dspampass)
        else:
            con = psycopg2.connect(host=serverhost, database=dspamdb, user=dspamuser, password=dspampass)
        con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT) # Needed for plpgsql
        cur = con.cursor()
    except Exception, e:
        print "ERROR: ",e
        sys.exit(2)
    try:
        f = open(purgescript, 'r')
        script = f.read()
        f.close()
    except Exception, e:
        print "ERROR: ",e
        sys.exit(3)
    try:
        cur.execute(script)
    except Exception, e:
        print "ERROR: ",e
        sys.exit(4)
    con.close()
    
if __name__ == '__main__':
    main()

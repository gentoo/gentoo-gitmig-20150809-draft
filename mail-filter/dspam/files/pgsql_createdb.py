#!/bin/env python

import sys, os
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

adminuser = ''
adminpass = ''

def inputStuff(title, default = None, empty = True):
    if default is not None:
        uinput = raw_input("%s [DEFAULT %s]: " %(title, default))
    else:
        uinput = raw_input("%s: " %(title))
    if default:
        if uinput == '':
            return default
    if uinput == '' and not empty:
        print "Error: Zero length input not allowed!"
        return inputStuff(title, default, empty)
    return uinput

def main():
    global adminuser
    if len(sys.argv) == 7:
        thiscript, serverhost, serverport, adminuser, dspamuser, dspamdb, createscript = sys.argv
    elif len(sys.argv) == 8:
        thiscript, serverhost, serverport, adminuser, dspamuser, dspamdb, createscript, vuserscript = sys.argv
    else:
        print "Usage: %s server_host server_port admin_user dspam_user dspam_dbname setup_DB_script [setup_virtual_user_script]" %(sys.argv[0])
        sys.exit(1)
    env = os.environ
    dspampass = env['DSPAM_PgSQLPass']
    con = connectasadmin(serverhost, serverport, 'template1')
    con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT) # CREATE DATABASE needs this
    cur = con.cursor()
    createDbAndUser(cur, dspamuser, dspampass, dspamdb)
    con.close()
    con = connectasadmin(serverhost, serverport, dspamdb)
    con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT) # CREATE LANGUAGE probably needs this
    cur = con.cursor()
    createLanguage(cur)
    con.close()
    executeScript(serverhost, serverport, dspamuser, dspampass, dspamdb, createscript)
    if len(sys.argv) == 8:
        executeScript(serverhost, serverport, dspamuser, dspampass, dspamdb, vuserscript)

def createDbAndUser(cur, dspamuser, dspampass, dspamdb):
    try:
        cur.execute("""CREATE USER %s WITH PASSWORD '%s' NOCREATEDB NOCREATEUSER;""" %(dspamuser, dspampass))
        cur.execute("""CREATE DATABASE %s;""" %(dspamdb))
        cur.execute("""GRANT ALL PRIVILEGES ON DATABASE %s TO %s;""" %(dspamdb, dspamuser))
        cur.execute("""GRANT ALL PRIVILEGES ON SCHEMA public TO %s;""" %(dspamuser))
        cur.execute("""UPDATE pg_database SET datdba=(SELECT usesysid FROM pg_shadow WHERE usename='%s') WHERE datname='%s';""" %(dspamuser, dspamdb))
    except Exception, e:
        print "ERROR:", e
        sys.exit(2)

def createLanguage(cur):
    try:
        cur.execute("CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler AS '$libdir/plpgsql', 'plpgsql_call_handler' LANGUAGE c;")
        cur.execute("CREATE FUNCTION plpgsql_validator(oid) RETURNS void AS '$libdir/plpgsql', 'plpgsql_validator' LANGUAGE c;")
        cur.execute("CREATE TRUSTED PROCEDURAL LANGUAGE plpgsql HANDLER plpgsql_call_handler VALIDATOR plpgsql_validator;")
    except Exception, e:
        print "ERROR:", e
        sys.exit(2)

def executeScript(serverhost, serverport, dspamuser, dspampass, dspamdb, script):
    try:
        if len(serverport) > 0:
            con = psycopg2.connect(host=serverhost, port=int(serverport), database=dspamdb, user=dspamuser, password=dspampass)
        else:
            con = psycopg2.connect(host=serverhost, database=dspamdb, user=dspamuser, password=dspampass)
        con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT) # Needed for plpgsql
        cur = con.cursor()
    except Exception, e:
        print "ERROR: ",e
        sys.exit(3)
    try:
        f = open(script, 'r')
        script = f.read()
        f.close()
    except Exception, e:
        print "ERROR: ",e
        sys.exit(4)
    try:
        cur.execute(script)
    except Exception, e:
        print "ERROR: ",e
        sys.exit(5)
    con.close()
    
def connectasadmin(serverhost, serverport, db):
    global adminuser, adminpass
    notconnected = 1
    while(notconnected):
        try:    
            if len(serverport) > 0:
                con = psycopg2.connect(host=serverhost, port=int(serverport), database=db, user=adminuser, password=adminpass)
            else:
                con = psycopg2.connect(host=serverhost, database=db, user=adminuser, password=adminpass)
            notconnected = 0
        except psycopg2.OperationalError, e:
            if 'no password' in e[0]:
                adminpass = inputStuff('Password')
            else:
                print e
                sys.exit(2)
        except Exception, e:
            print e
            sys.exit(2)
    return con

if __name__ == '__main__':
    main()

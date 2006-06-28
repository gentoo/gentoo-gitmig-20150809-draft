#!/bin/sh

LANGUAGE=C

if [ -z $TSP_VERBOSE ]; then
   TSP_VERBOSE=0
fi

KillProcess()
{
   if [ ! -z $TSP_VERBOSE ]; then
      if [ $TSP_VERBOSE -ge 2 ]; then
         echo killing $*
      fi
   fi
   PID=`ps axww | grep $1 | grep -v grep | awk '{ print $1;}'`
   echo $PID
   if [ ! -z $PID ]; then
      kill $PID
   fi
}

Display()
{
   if [ -z $TSP_VERBOSE ]; then
      return;
   fi
   if [ $TSP_VERBOSE -lt $1 ]; then
      return;
   fi
   shift
   echo "$*"
}

Exec()
{
   if [ ! -z $TSP_VERBOSE ]; then
      if [ $TSP_VERBOSE -ge 2 ]; then
         echo $*
      fi
   fi
   $* # Execute command
   if [ $? -ne 0 ]; then
      echo "Error while executing $1"
      echo "   Command: $*"
      exit 1
   fi
}

ExecNoCheck()
{
   if [ ! -z $TSP_VERBOSE ]; then
      if [ $TSP_VERBOSE -ge 2 ]; then
         echo $*
      fi
   fi
   $* # Execute command
}

# Program localization 

Display 1 "--- Start of configuration script. ---"
Display 1 "Script: " `basename $0`

ifconfig=/sbin/ifconfig
route=/sbin/route
ipconfig=/sbin/ip
rtadvd=/usr/sbin/radvd
sysctl=/sbin/sysctl
rtadvdconfigfilename=radvd.conf
rtadvdconfigfile=/etc/$rtadvdconfigfilename

if [ -z $TSP_HOME_DIR ]; then
   echo "TSP_HOME_DIR variable not specified!;"
   exit 1
fi

if [ ! -d $TSP_HOME_DIR ]; then
   echo "Error : directory $TSP_HOME_DIR does not exist"
   exit 1
fi
#

if [ -z $TSP_HOST_TYPE ]; then
   echo Error: TSP_HOST_TYPE not defined.
   exit 1
fi

#change to upper case
TSP_HOST_TYPE=`echo $TSP_HOST_TYPE | tr a-z A-Z`

if [ X"${TSP_HOST_TYPE}" = X"HOST" ] || [ X"${TSP_HOST_TYPE}" = X"ROUTER" ]; then
   #
   # Configured tunnel config (IPv6) 

   Display 1 "$TSP_TUNNEL_INTERFACE setup"
   Display 1 "Setting up link to $TSP_SERVER_ADDRESS_IPV4"
   if [ -x $ipconfig ]; then
     Exec $ipconfig tunnel add $TSP_TUNNEL_INTERFACE mode sit ttl 64 remote $TSP_SERVER_ADDRESS_IPV4
   else
     Exec $ifconfig $TSP_TUNNEL_INTERFACE tunnel ::$TSP_SERVER_ADDRESS_IPV4
   fi

   Exec $ifconfig $TSP_TUNNEL_INTERFACE up

   PREF=`echo $TSP_CLIENT_ADDRESS_IPV6 | sed "s/:0*/:/g" |cut -d : -f1-2`
   OLDADDR=`$ifconfig $TSP_TUNNEL_INTERFACE | grep "inet6.* $PREF" | sed -e "s/^.*inet6 addr: //" -e "s/ Scope.*\$//"`
   if [ ! -z $OLDADDR ]; then
      Display 1 "Removing old IPv6 address $OLDADDR"
      Exec $ifconfig $TSP_TUNNEL_INTERFACE inet6 del $OLDADDR
   fi
   Display 1 "This host is: $TSP_CLIENT_ADDRESS_IPV6/$TSP_TUNNEL_PREFIXLEN"
   Exec $ifconfig $TSP_TUNNEL_INTERFACE add $TSP_CLIENT_ADDRESS_IPV6/$TSP_TUNNEL_PREFIXLEN

   # 
   # Default route  
   Display 1 "Adding default route"
   ExecNoCheck $route -A inet6 del ::/0 2>/dev/null # delete old default route
   Exec $route -A inet6 add ::/0 dev $TSP_TUNNEL_INTERFACE
   Exec $route -A inet6 add 2000::/3 dev $TSP_TUNNEL_INTERFACE
fi

# Router configuration if required
if [ X"${TSP_HOST_TYPE}" = X"ROUTER" ]; then
   Display 1 "Router configuration"
   Display 1 "Kernel setup"
   #Better way on linux to avoid loop with the remaining /48?
   $route -A inet6 add $TSP_PREFIX::/$TSP_PREFIXLEN dev $TSP_HOME_INTERFACE 2>/dev/null
   Exec $sysctl -w net.ipv6.conf.all.forwarding=1 # ipv6_forwarding enabled
   Display 1 "Adding prefix to $TSP_HOME_INTERFACE"
   OLDADDR=`$ifconfig $TSP_HOME_INTERFACE | grep "inet6.* $PREF" | sed -e "s/^.*inet6 addr: //" -e "s/ Scope.*\$//"`
   if [ ! -z $OLDADDR ]; then
      Display 1 "Removing old IPv6 address $OLDADDR"
      Exec $ifconfig $TSP_HOME_INTERFACE inet6 del $OLDADDR
   fi
   Exec $ifconfig $TSP_HOME_INTERFACE add $TSP_PREFIX:1::1/64
   # Router advertisement configuration 
   Display 1 "Create new $rtadvdconfigfile"
   echo "##### radvd.conf made by TSP ####" > "$rtadvdconfigfile"
   echo "interface $TSP_HOME_INTERFACE" >> "$rtadvdconfigfile"
   echo "{" >> "$rtadvdconfigfile"
   echo " AdvSendAdvert on;" >> "$rtadvdconfigfile"
   echo " prefix $TSP_PREFIX:0001::/64" >> "$rtadvdconfigfile"
   echo " {" >> "$rtadvdconfigfile"
   echo " AdvOnLink on;" >> "$rtadvdconfigfile"
   echo " AdvAutonomous on;" >> "$rtadvdconfigfile"
   echo " AdvRouterAddr on;" >> "$rtadvdconfigfile"
   echo " };" >> "$rtadvdconfigfile"
   echo "};" >> "$rtadvdconfigfile"
   echo "" >> "$rtadvdconfigfile"
   if [ -f /var/run/radvd/radvd.pid ]; then
       /etc/init.d/radvd stop
   fi
   if [ -f $rtadvdconfigfile ]; then
       /etc/init.d/radvd start
   else
      echo "Error : file $rtadvdconfigfile not found"
      exit 1
   fi
fi

Display 1 "--- End of configuration script. ---"

exit 0

#---------------------------------------------------------------------


#!/bin/sh

hping() {
  host=`echo $1 | sed -e 's:.*\://::' -e 's:/.*::'`
  result=`ping -c3 -q ${host} 2>/dev/null`
  if [ -n "$result" ]
  then
    if [ -z "`echo $result | sed 's:.*0 packets received.*:N:'`" ]
    then
      result=`echo $result | sed -e "s:.*= [0-9|\.]*/::" -e "s:/[0-9|\.]* ms::" | awk '{ printf ("%04i\n",(atof $1)) }'`
      echo $result $1
    else
      echo 9999 $1
    fi
  fi
}
pingall() {

  for i in $1
  do
    hping $i
  done
}
pingall "$1" | sort | sed -e "s:[0-9]* ::"
#pingall "$1"


#! /bin/sh

base=/opt/snipsnap
jar=$base/lib

if [ -f $HOME/.gentoo/java-env ] ; then
  source $HOME/.gentoo/java-env
else
  JAVA_HOME=`java-config --jdk-home`
  if [ -z $JAVA_HOME ] ; then
    JAVA_HOME=`java-config --jre-home`
  fi
fi

if [ -z "$JAVA_HOME" ]; then
  echo "Please set JAVA_HOME environment variable!"
  echo "A Java SDK of at least version 1.3 is required!"
  exit
fi

# check whether the java compiler is available
if [ ! -f $JAVA_HOME/lib/tools.jar -a ! -f /System/Library/Frameworks/JavaVM.framework/Classes/classes.jar ]; then
  echo "$JAVA_HOME/lib/tools.jar or MacOS X pendant not found, cannot compile jsp files"
  echo "Make sure tools.jar or similar from the Java SDK is in the classpath!"
  exit 
else
  if [ -f /System/Library/Frameworks/JavaVM.framework/Classes/classes.jar ]; then
    TOOLS=/System/Library/Frameworks/JavaVM.framework/Classes/classes.jar
  else
    TOOLS=$JAVA_HOME/lib/tools.jar
  fi
fi

if [ ! -f $jar/snipsnap.jar ]; then
  echo "$jar/snipsnap.jar missing, please compile application first"
  exit
fi

# put classpath together (this is a script-local variable)
CLASSPATH=$jar/org.mortbay.jetty.jar:$jar/javax.servlet.jar:$jar/org.apache.crimson.jar:$jar/org.apache.jasper.jar:$jar/jdbcpool.jar:$jar/mckoidb.jar:$TOOLS

if [ "$1" = "admin" ]; then
  $JAVA_HOME/bin/java -cp $CLASSPATH:$jar/snipsnap.jar org.snipsnap.server.AppServer -admin "$2" "$3" 
  exit
fi

if [ "$1" = "-debug" ]; then
  DBG="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5000"
fi

# execute application server
[ -f $base/server.log ] && mv $base/server.log $base/server.log.old
cd $base
$JAVA_HOME/bin/java -server $DBG -cp $CLASSPATH:$jar/snipsnap.jar -Duser.dir=$base org.snipsnap.server.AppServer $cmdline > $base/server.log 2>&1 &
echo "$!" > /var/run/snipsnap.pid  

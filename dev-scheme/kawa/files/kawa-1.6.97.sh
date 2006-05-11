#! /bin/sh
KAWALIB=/usr/share/kawa/kawa-1.6.97.jar
export CLASSPATH=`/usr/bin/java-config --classpath`:${KAWALIB}
`/usr/bin/java-config --java` kawa.repl "$@"

#!/bin/bash

JAVA=`java-config -J`

localclasspath=${CLASSPATH}
localclasspath=${localclasspath}:`java-config -p datavision`
localclasspath=${localclasspath}:`java-config -p minml2`
localclasspath=${localclasspath}:`java-config -p jcalendar`
localclasspath=${localclasspath}:`java-config -p jruby`
localclasspath=${localclasspath}:`java-config -p gnu-regexp-1`
localclasspath=${localclasspath}:`java-config -p itext`


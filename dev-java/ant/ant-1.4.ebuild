# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.4.ebuild,v 1.1 2001/10/07 16:05:20 achim Exp $

A="jakarta-ant-${PV}-src.tar.gz ant-optional-gentoo-${PV}.tgz"
S=${WORKDIR}/jakarta-ant-${PV}
DESCRIPTION="Build system for java"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ant/release/v${PV}/src/jakarta-ant-${PV}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

DEPEND="virtual/glibc
	>=dev-lang/jdk-1.3"

src_unpack() {
    unpack jakarta-ant-${PV}-src.tar.gz
    cd ${S}/src/script
    cp antRun antRun.orig
    tr -d '\r' < antRun.orig > antRun
    cd ../..
    mkdir lib/opt
    cd lib/opt
    unpack ant-optional-gentoo-${PV}.tgz
}
src_compile() {

  CLASSPATH="/opt/java/lib/tools.jar"
  for i in ${S}/lib/opt 
  do
    CLASSPATH=$CLASSPATH:$i
  done
  export CLASSPATH
  export JAVA_HOME=/opt/java

  echo "Building ant..."
  ./bootstrap.sh
  mv bootstrap/bin .

}

src_install() {
    exeinto /usr/bin
    doexe bin/ant bin/antRun bin/runant.pl
    insinto /usr/lib/java
    doins build/lib/*.jar lib/*.jar
    insinto /usr/lib/java/ant
    doins lib/opt/*.jar

    dodoc LICENSE README WHATSNEW
    docinto html
    cd docs
    dodoc ant_in_anger.html
    docinto html/ant2
    dodoc ant2/*.html
    docinto txt
    dodoc ant2/*.txt
    cp -a manual ${D}/usr/share/doc/${PF}/html
    prepalldocs
}




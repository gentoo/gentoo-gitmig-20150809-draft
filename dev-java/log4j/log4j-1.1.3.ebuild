# Copyright (c) Jordan Armstrong, 2002
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jordan Armstrong <jordan@papercrane.net>

A="jakarta-log4j-${PV}.tar.gz"
S=${WORKDIR}/jakarta-log4j-${PV}
DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="http://jakarta.apache.org/log4j/jakarta-log4j-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

DEPEND=">=virtual/jdk-1.3"

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	sh build.sh jar || die
}

src_install() {
	dojar dist/lib/*.jar
	dohtml -r docs/*
}

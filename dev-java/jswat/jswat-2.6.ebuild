# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.6.ebuild,v 1.3 2002/07/17 19:51:14 drobbins Exp $

S="${WORKDIR}/jswat"
DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="http://www.bluemarsh.com/binaries/java/jswat/jswat2-src-20020617.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="*"

DEPEND=">=dev-java/ant-1.4.1"
#this next line should be changed to >=virtual/jdk once we have a bunch of 1.4 JDK's
RDEPEND=">=dev-java/sun-jdk-1.4"

src_compile() {
	cd build
	# we cannot use jikes here because we would get
	# a java.lang.VerifyError from the ClassLoader (why?)
	ant || die "compile problem"
}

src_install () {
	# install it as new CLASSPATH package because other programs
	# (like app-editors/jedit) can make use of it
	cd dist/jswat
	dojar jswat2.jar parser.jar

	cd ../..

	echo -e >jswat '#!/bin/sh\njava -classpath /usr/share/jswat/lib/jswat2.jar:/opt/sun-jdk-1.4.0/lib/tools.jar com.bluemarsh.jswat.Main $@'
	chmod 755 jswat
	dobin jswat

	dodoc AUTHORS.txt BUGS.txt HISTORY.txt LICENSE.txt OLD_HISTORY.txt TODO.txt
	dohtml README.html
	dohtml -r docs
}

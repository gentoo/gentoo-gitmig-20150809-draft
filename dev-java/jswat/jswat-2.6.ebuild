# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Maik Schreiber <bZ@iq-computing.de>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.6.ebuild,v 1.1 2002/06/18 23:54:47 rphillips Exp $

S="${WORKDIR}/jswat"
DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
LICENSE="GPL-2"
DEPEND=">=dev-java/ant-1.4.1"
RDEPEND=">=virtual/jdk-1.4"
SRC_URI="http://www.bluemarsh.com/binaries/java/jswat/jswat2-src-20020617.tar.gz"

src_compile() {
	cd build
	# we cannot use jikes here because we would get
	# a java.lang.VerifyError from the ClassLoader (why?)
	ant || die
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

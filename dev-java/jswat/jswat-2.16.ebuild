# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.16.ebuild,v 1.2 2003/04/30 16:44:01 absinthe Exp $

inherit java-pkg

S="${WORKDIR}/${PN}-${PV}"
DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="http://switch.dl.sourceforge.net/sourceforge/jswat/${PN}-src-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 sparc ppc"
DEPEND=">=dev-java/ant-1.4.1"
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	echo ${S}
	echo "${PV}" | ant || die "compile problem"
}

src_install () {
	java-pkg_dojar build/dist/${PN}-${PV}/*.jar
	echo -e >jswat '#!/bin/sh\njava -classpath /usr/share/jswat/lib/jswat.jar:$JDK_HOME/lib/tools.jar com.bluemarsh.jswat.Main $@'
	chmod 755 jswat
	dobin jswat
	dodoc AUTHORS.txt BUGS.txt HISTORY.txt LICENSE.txt OLD_HISTORY.txt TODO.txt
	dohtml README.html
	dohtml -r docs
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jsynthlib/jsynthlib-0.19_pre20041220.ebuild,v 1.1 2005/01/10 04:50:56 jnc Exp $

inherit java-pkg

DESCRIPTION="Java-based MIDI hardware SysEx librarian"
HOMEPAGE="http://www.jsynthlib.org/"
SRC_URI="http://dev.gentoo.org/~jnc/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="dist"
	use jikes && antflags="${antflags} Dbuild.compiler=jikes"
	ant ${antflags}
}

src_install() {
	mv dist/JSynthLib-*cvs.jar dist/${P}.jar
	java-pkg_dojar dist/${P}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/"${PN} >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/${P}.jar '$*' >> ${PN}

	dobin ${PN}
}

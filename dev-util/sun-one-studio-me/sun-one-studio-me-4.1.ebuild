# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sun-one-studio-me/sun-one-studio-me-4.1.ebuild,v 1.3 2004/03/23 21:02:27 dholm Exp $

DESCRIPTION="Sun ONE Studio Mobile Edition"
HOMEPAGE="http://wwws.sun.com/software/sundev/jde/studio_me/index.html"
SRC_URI="ffj_me_linux.bin"
LICENSE="sun-bcla-sos"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""
DEPEND=">=virtual/jdk-1.4.1"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and move it to ${DISTDIR}"
}


src_unpack() {
	unzip -q ${DISTDIR}/${SRC_URI} -d ${S}
}

src_install() {
	addwrite "/var/lib/rpm/__db.Name."
	addwrite "/var/lib/rpm/Name"
	${JAVA_HOME}/bin/java -DjdkHome=`java-config --jdk-home` -DforteHome="${D}/opt/s1studiome/" run -silent
}

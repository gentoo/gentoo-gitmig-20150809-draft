# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xpg/xpg-0.1.ebuild,v 1.7 2004/08/05 13:51:26 sejo Exp $
inherit java-pkg

DESCRIPTION="GUI for PostgreSQL written in Java"
HOMEPAGE="http://www.kazak.ws/xpg/"
SRC_URI="mirror://gentoo/xpg-current.tar.gz
	mirror://gentoo/xpg-icons.tar.gz"
S="${WORKDIR}/xpg-current"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4"

src_compile() {
	make || die "make problems"
}
src_install () {
	cd ${S}
	java-pkg_dojar bin/*.jar
	dodir /usr/share/xpg /usr/share/pixmaps/
	cp -Rdp styles ${D}/usr/share/xpg/
	cp -Rdp ${WORKDIR}/*.jpg ${D}/usr/share/pixmaps/
	cp -Rdp ${WORKDIR}/*.xpm ${D}/usr/share/pixmaps/
	dohtml -r doc/*

	echo -e "#!/bin/bash\nexport XPG_HOME=/usr/share/xpg\njava -Dxpghome=\${XPG_HOME} -jar \${XPG_HOME}/lib/xpg.jar" > xpg
	dobin xpg
}

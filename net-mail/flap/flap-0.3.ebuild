# Copyright 2002 Maik Schreiber
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.7 2002/05/18 17:25:12 agenkin Exp

S="${WORKDIR}/${P}-src"
DESCRIPTION="mail user agent written in Java"
HOMEPAGE="http://flap.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/flap/${P}-src.tar.gz"

DEPEND=">=dev-java/ant-1.4.1
	>=dev-java/jikes-1.15"
RDEPEND=">=virtual/jdk-1.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	ant || die
}

src_install () {
	mkdir -m 755 -p ${D}/usr/flap
	mkdir -m 755 ${D}/usr/bin
	mkdir -m 755 -p ${D}/etc/env.d
	cp -R flap.jar flap.sh lib ${D}/usr/flap
	echo >${D}/etc/env.d/10flap "FLAP_HOME=/usr/flap"
	ln -s ../flap/flap.sh ${D}/usr/bin/flap
	chmod 644 ${D}/usr/flap/flap.jar ${D}/usr/flap/lib/* ${D}/etc/env.d/10flap
	chmod 755 ${D}/usr/flap/lib ${D}/usr/flap/flap.sh
}

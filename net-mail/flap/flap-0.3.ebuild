# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/flap/flap-0.3.ebuild,v 1.4 2002/08/14 12:05:25 murphy Exp $

S="${WORKDIR}/${P}-src"
DESCRIPTION="mail user agent written in Java"
HOMEPAGE="http://flap.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/flap/${P}-src.tar.gz"

DEPEND=">=dev-java/ant-1.4.1
	>=dev-java/jikes-1.15"
RDEPEND="virtual/jdk"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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

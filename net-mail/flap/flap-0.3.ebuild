# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/flap/flap-0.3.ebuild,v 1.7 2003/02/13 14:31:54 vapier Exp $

DESCRIPTION="mail user agent written in Java"
HOMEPAGE="http://flap.sourceforge.net/"
SRC_URI="mirror://sourceforge/flap/${P}-src.tar.gz"

DEPEND=">=dev-java/ant-1.4.1
	>=dev-java/jikes-1.15"
RDEPEND="virtual/jdk"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

S="${WORKDIR}/${P}-src"

src_compile() {
	ant || die
}

src_install() {
	dodir /usr/flap
	dodir /usr/bin
	dodir /etc/env.d
	cp -R flap.jar flap.sh lib ${D}/usr/flap
	echo >${D}/etc/env.d/10flap "FLAP_HOME=/usr/flap"
	ln -s ../flap/flap.sh ${D}/usr/bin/flap
	chmod 644 ${D}/usr/flap/flap.jar ${D}/usr/flap/lib/* ${D}/etc/env.d/10flap
	chmod 755 ${D}/usr/flap/lib ${D}/usr/flap/flap.sh
}

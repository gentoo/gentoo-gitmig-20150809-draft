# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrix/tetrix-1.13.16.1.40c.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $


MY_SV=${PV#*.*.*.}
MY_PV=${PV%.${MY_SV}}

MY_P="tetrinetx-${MY_PV}+qirc-${MY_SV}"

DESCRIPTION="A GNU TetriNET server"
SRC_URI="mirror://sourceforge/tetrinetx/${MY_P}.tar.gz"

HOMEPAGE="http://tetrinetx.sourceforge.net/"
KEYWORDS="x86"
LICENSE="GPL-2"

SLOT="0"

DEPEND="net-libs/adns"

S="${WORKDIR}/${MY_P}/src"

src_compile() {
	./c || die "compile failed"
}

src_install() {
	dodir /opt/tetrix /etc/init.d

	mv ../bin/* ${D}/opt/tetrix/

	cp ${FILESDIR}/launch_tetrix ${D}/opt/tetrix/
	cp ${FILESDIR}/tetrix ${D}/etc/init.d/tetrix
}

pkg_postinst() {
	chmod ug+rwx /etc/init.d/tetrix /opt/tetrix/launch_tetrix
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rec/rec-1.6.ebuild,v 1.5 2007/03/05 04:12:58 genone Exp $

inherit eutils

DESCRIPTION="Reverse Engineering Compiler"
HOMEPAGE="http://www.backerstreet.com/rec/rec.htm"
SRC_URI="http://www.backerstreet.com/rec/rec16lx.zip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="sys-libs/ncurses sys-libs/gpm"
S=${WORKDIR}

src_unpack() {
	unzip -L -d ${S} -q ${DISTDIR}/${A} || die
}

src_compile() {
	sed -i 's#\(^.*$\)#/opt/rec/\1#g' proto.lst
}

src_install() {
	dodir /opt/rec
	into /opt
	dobin rec

	insinto /opt/rec
	doins proto.lst
	doins string.o stdio.o stdlib.o fcntl.o winbase.o winuser.o wingdi.o
	dodoc readme copyrite
}

pkg_postinst() {
	elog "/opt/rec/proto.lst should be copied into the working"
	elog "directory of new projects, this will make rec aware of common"
	elog "prototypes."
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/connect/connect-100.ebuild,v 1.3 2009/09/23 19:35:04 patrick Exp $

inherit toolchain-funcs

IUSE=""
DESCRIPTION="network connection relaying command"
HOMEPAGE="http://www.meadowy.org/~gotoh/projects/connect/"
SRC_URI="http://www.meadowy.org/~gotoh/ssh/${PN}-r${PV}.c"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=""
S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} ${PN}-r${PV}.c || die "compiler failed"
}

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	einfo
	einfo "There is no manpage, please see ${HOMEPAGE} for details"
	einfo
}

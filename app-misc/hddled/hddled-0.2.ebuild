# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hddled/hddled-0.2.ebuild,v 1.1 2012/04/14 11:55:24 xmw Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="use scroll lock led as "
HOMEPAGE="http://members.optusnet.com.au/foonly/whirlpool/code/"
SRC_URI="http://xmw.de/mirror/${PN}/${P}.c"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	cp -v "${DISTDIR}"/${A} ${PN}.c || die
}

src_compile() {
	$(tc-getCC) ${CFLAGS} -o ${PN} ${PN}.c ${LDFLAGS} || die
	if use X ; then
		$(tc-getCC) ${CFLAGS} -DX -lX11 -o x${PN} ${PN}.c ${LDFLAGS} || die
	fi
}

src_install() {
	dobin ${PN} || die
	if use X ; then
		dobin x${PN} || die
		elog "X version was renamed to x${PN}"
	fi
}

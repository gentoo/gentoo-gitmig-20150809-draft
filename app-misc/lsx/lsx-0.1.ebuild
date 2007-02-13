# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lsx/lsx-0.1.ebuild,v 1.4 2007/02/13 12:58:34 peper Exp $

inherit toolchain-funcs

DESCRIPTION="list executables"
HOMEPAGE="http://tools.suckless.org/view.sh/other+tools"
SRC_URI="http://suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/.*strip.*//" \
		Makefile || die "sed failed"

	sed -i \
		-e "s/CFLAGS = -Os/CFLAGS +=/" \
		-e "s/LDFLAGS =/LDFLAGS +=/" \
		config.mk || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	# collision with net-dialup/lrzsz
	mv "${D}/usr/bin/${PN}" "${D}/usr/bin/${PN}-suckless"

	dodoc README
}

pkg_postinst() {
	einfo "Run ${PN} with ${PN}-suckless"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-1.5-r1.ebuild,v 1.1 2010/06/24 12:39:39 hwoarang Exp $

inherit eutils

DESCRIPTION="Advanced command line hexadecimail editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/radare-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gui lua vala"

DEPEND="sys-libs/readline
		dev-lang/python
		lua? ( dev-lang/lua )
		vala? ( dev-lang/vala )
		"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ldflags.patch
	# fix documentation installation
	sed -i "s:doc/${PN}:doc/${PF}:g" \
		Makefile.acr global.h.acr src/Makefile.acr wscript dist/maemo/Makefile
}

src_compile() {
	econf $(use_with gui) || die "configure failed"
	emake -j1 || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

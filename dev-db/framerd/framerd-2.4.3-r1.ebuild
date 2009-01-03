# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/framerd/framerd-2.4.3-r1.ebuild,v 1.16 2009/01/03 16:23:16 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a portable, distributed, object-oriented database designed to support knowledge bases"
HOMEPAGE="http://www.framerd.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 x86"
IUSE="readline"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-setup.fdx.patch \
		"${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	econf \
		$(use_with readline) \
		--enable-shared

	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF}
	sed -i -e "s:${D}::" "${D}"/usr/share/framerd/framerd.cfg \
		|| die "sed failed"
}

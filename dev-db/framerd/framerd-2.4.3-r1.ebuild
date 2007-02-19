# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/framerd/framerd-2.4.3-r1.ebuild,v 1.15 2007/02/19 08:27:18 dirtyepic Exp $

inherit eutils

DESCRIPTION="FramerD is a portable distributed object-oriented database designed to support the maintenance and sharing of knowledge bases."
HOMEPAGE="http://www.framerd.org/"
SRC_URI="mirror://sourceforge/framerd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 x86"
IUSE="readline"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-setup.fdx.patch
}

src_compile() {
	econf \
		$(use_with readline) \
		--enable-shared \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	mv ${D}/usr/share/framerd/framerd.cfg ${D}/usr/share/framerd/framerd.cfg_orig
	perl -pe "s|${D}||" ${D}/usr/share/framerd/framerd.cfg_orig > ${D}/usr/share/framerd/framerd.cfg
	rm ${D}/usr/share/framerd/framerd.cfg_orig
}

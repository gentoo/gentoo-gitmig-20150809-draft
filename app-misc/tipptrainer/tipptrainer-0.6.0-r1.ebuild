# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tipptrainer/tipptrainer-0.6.0-r1.ebuild,v 1.3 2007/04/07 20:34:57 opfer Exp $

WX_GTK_VER="2.6"

inherit flag-o-matic eutils wxwidgets

DESCRIPTION="A touch typing trainer (German/English)"
HOMEPAGE="http://tipptrainer.pingos.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
DEPEND=">=dev-libs/glib-1.2.7
	=x11-libs/wxGTK-2.6*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41_extra_qualification.patch
}

src_compile() {
	need-wxwidgets gtk2
	append-flags "-fno-strict-aliasing"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}

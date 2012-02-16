# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ptabtools/ptabtools-0.5.0.ebuild,v 1.2 2012/02/16 18:54:58 phajdan.jr Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Utilities for PowerTab Guitar files (.ptb)"
HOMEPAGE="http://www.samba.org/~jelmer/ptabtools/"
SRC_URI="http://www.samba.org/~jelmer/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-libs/popt
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_install() {
	emake DESTDIR="${D}" libdir="/usr/$(get_libdir)" install
	dodoc AUTHORS NEWS README ROADMAP TODO
}

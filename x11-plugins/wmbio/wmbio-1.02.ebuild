# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbio/wmbio-1.02.ebuild,v 1.10 2008/11/25 23:33:51 tcunha Exp $

inherit eutils

DESCRIPTION="a Window Maker applet that shows your biorhythm"
SRC_URI="http://wmbio.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://wmbio.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Honour Gentoo CFLAGS
	epatch "${FILESDIR}"/${PN}-Makefile.patch
}

src_compile() {
	emake || die "emake failed."
}

src_install () {
	dobin wmbio || die "dobin failed."
	dodoc ../{AUTHORS,ChangeLog,NEWS,README}
}

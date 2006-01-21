# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obpager/obpager-1.8.ebuild,v 1.7 2006/01/21 12:49:43 nelchael Exp $

DESCRIPTION="Lightweight pager designed to be used with NetWM-compliant window manager"
HOMEPAGE="http://obpager.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libXext
		x11-libs/libX11 )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# this makes it compile :-)
	sed -i -e '18s/^.*$/#include <errno.h>/' src/main.cc
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin obpager
	dodoc README
}

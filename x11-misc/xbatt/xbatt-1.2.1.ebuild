# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbatt/xbatt-1.2.1.ebuild,v 1.8 2006/09/21 11:47:02 nelchael Exp $

DESCRIPTION="Notebook battery indicator for X"
HOMEPAGE="http://www.clave.gr.jp/~eto/xbatt/"
SRC_URI="http://www.clave.gr.jp/~eto/xbatt/${P}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXaw
		x11-libs/libXext
		x11-libs/libxkbfile
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
			x11-misc/imake )
		virtual/x11 )"

src_compile() {
	xmkmf || die
	make xbatt || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README* COPYRIGHT
}

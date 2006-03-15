# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-1.1.ebuild,v 1.8 2006/03/15 08:47:28 spyderous Exp $

DESCRIPTION="Terminal to display (multiple) log files on the root window"
HOMEPAGE="http://www.goof.com/pcg/marc/root-tail.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ppc ppc64"
IUSE=""

RDEPEND="|| ( x11-libs/libXext virtual/x11 )"
DEPEND=">=sys-apps/sed-4
	|| ( ( x11-misc/imake
			app-text/rman
			x11-misc/gccmakedep
		) 
		virtual/x11
	)"

src_compile() {
	xmkmf -a
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install install.man || die "make install failed"
	dodoc Changes README
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtoolwait/xtoolwait-1.3-r1.ebuild,v 1.12 2006/10/21 22:42:49 omp Exp $

DESCRIPTION="Xtoolwait notably decreases the startup time of an X session"
HOMEPAGE="http://www.hacom.nl/~richard/software/xtoolwait.html"
SRC_URI="http://www.hacom.nl/~richard/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-proto/xproto
	app-text/rman"

src_compile() {
	xmkmf || die "xmkmf failed"
	emake || die "emake failed"
}

src_install() {
	emake BINDIR=/usr/bin \
		MANPATH=/usr/share/man \
		DOCDIR=/usr/share/doc/${PF} \
		DESTDIR="${D}" install || die "emake install failed"
	emake BINDIR=/usr/bin \
		MANPATH=/usr/share/man \
		DOCDIR=/usr/share/doc/${PF} \
		DESTDIR="${D}" install.man || die "emake install.man failed"
	dodoc CHANGES README
}


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtoolwait/xtoolwait-1.3.ebuild,v 1.15 2004/10/12 13:22:12 sejo Exp $

SRC_URI="http://www.hacom.nl/~richard/software/${P}.tar.gz"
HOMEPAGE="http://www.hacom.nl/~richard/software/xtoolwait.html"
DESCRIPTION="Xtoolwait notably decreases the startup time of an X session"
DEPEND="virtual/x11"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ia64 ~amd64 ~ppc"
IUSE=""

src_compile() {
	xmkmf || die "xmkmf failed"
	emake || die "emake failed"
}

src_install() {
	emake BINDIR=/usr/bin \
		MANPATH=/usr/share/man \
		DOCDIR=/usr/share/doc/${PF} \
		DESTDIR=${D} install || die "emake install failed"
	emake BINDIR=/usr/bin \
		MANPATH=/usr/share/man \
		DOCDIR=/usr/share/doc/${PF} \
		DESTDIR=${D} install.man || die "emake install.man failed"
	dodoc CHANGES COPYING-2.0 README || die "dodoc failed"
}


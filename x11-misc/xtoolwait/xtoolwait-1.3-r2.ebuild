# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtoolwait/xtoolwait-1.3-r2.ebuild,v 1.1 2010/08/31 01:32:42 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Xtoolwait notably decreases the startup time of an X session"
HOMEPAGE="http://www.hacom.nl/~richard/software/xtoolwait.html"
SRC_URI="http://www.hacom.nl/~richard/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	app-text/rman"

src_prepare() {
	xmkmf || die "xmkmf failed"
	sed -i Makefile \
		-e '/CC = /d' \
		-e '/EXTRA_LDOPTIONS = /d' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CCOPTIONS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}" \
		|| die "emake failed"
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

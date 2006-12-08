# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/9libs/9libs-1.0-r1.ebuild,v 1.2 2006/12/08 23:14:02 masterdriverz Exp $

DESCRIPTION="A package of Plan 9 compatibility libraries"
HOMEPAGE="http://www.netlib.org/research/9libs/9libs-1.0.README"
SRC_URI="ftp://www.netlib.org/research/9libs/${P}.tar.bz2"

LICENSE="PLAN9"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| (
	( >=x11-proto/xproto-7.0.4
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXt-1.0.0 )
	virtual/x11 )"

RDEPEND="$DEPEND
	!dev-libs/libevent"

src_compile() {
	econf \
		--includedir=/usr/include/9libs \
		--enable-shared \
		|| die "econf failed"
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README
}

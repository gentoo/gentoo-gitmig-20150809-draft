# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.5-r2.ebuild,v 1.13 2006/02/04 00:36:22 vapier Exp $

inherit eutils

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE="imlib mmx pcre truetype"

DEPEND="|| ( ( x11-libs/libXt x11-proto/xproto x11-libs/libICE x11-libs/libSM x11-libs/libX11 ) virtual/x11 )
	truetype? ( =media-libs/freetype-1* )
	imlib? ( media-libs/imlib2 )
	pcre? ( dev-libs/libpcre )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libast-64bit.patch
}

src_compile() {
	econf \
		$(use_enable imlib) \
		$(use_enable mmx) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README DESIGN ChangeLog
}

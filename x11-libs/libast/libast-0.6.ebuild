# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.6.ebuild,v 1.1 2004/11/04 00:51:50 vapier Exp $

inherit 64-bit eutils

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="imlib mmx perl"

DEPEND="virtual/x11
	=media-libs/freetype-1*
	imlib? ( media-libs/imlib2 )
	perl? ( dev-libs/libpcre )"

fsrc_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libast-64bit.patch
}

src_compile() {
	econf \
		$(use_with imlib) \
		$(use_enable mmx) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README DESIGN ChangeLog
}

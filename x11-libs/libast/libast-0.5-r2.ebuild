# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.5-r2.ebuild,v 1.2 2004/02/29 21:34:53 vapier Exp $

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="X imlib mmx perl"

DEPEND="virtual/x11
	=media-libs/freetype-1*
	X? ( imlib? ( media-libs/imlib2 ) )
	perl? ( dev-libs/libpcre )"

src_compile() {
	local myconf
	use X && use imlib \
		&& myconf="--with-imlib" \
		|| myconf="--without-imlib"
	econf \
		${myconf} \
		`use_enable mmx` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README DESIGN ChangeLog
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.5-r1.ebuild,v 1.7 2004/01/02 21:28:23 aliz Exp $

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc mips alpha arm hppa"
IUSE="imlib mmx perl"

DEPEND="virtual/x11
	=media-libs/freetype-1*
	imlib? ( media-libs/imlib2 )
	perl? ( dev-libs/libpcre )"

src_compile() {
	local myconf
	myconf="$myconf `use_with imlib`"
	if [ "${ARCH}" == "x86" ]; then
		myconf="`use_enable mmx`"
	fi

	econf $myconf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}

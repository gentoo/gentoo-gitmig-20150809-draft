# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/terminus-font/terminus-font-4.00.ebuild,v 1.1 2003/04/23 09:59:04 twp Exp $

DESCRIPTION="A clean fixed font for the console and X11"
HOMEPAGE="http://www.is-vn.bg/hamster/jimmy-en.htm"
SRC_URI="http://www.is-vn.bg/hamster/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"

DEPEND="X? ( virtual/x11 ) dev-lang/perl"
RDEPEND="X? ( virtual/x11 )"

src_compile() {
        make psf || die

        # If user wants fonts for X11
        if [ -n "`use X`" ]; then
                make pcf || die
        fi
}

src_install() {
        ( cd vga && ../configure --prefix=${D}/usr )
        make -f vga/Makefile install || die

        # If user wants fonts for X11
        if [ -n "`use X`" ]; then
                ( cd x11 && ../configure --prefix=${D}/usr )
                perl -pi -e 's/local/misc/;' x11/Makefile
                make -f x11/Makefile install || die
        fi

        dodoc README*
}

pkg_postinst() {
        mkfontdir ${ROOT}usr/X11R6/fonts/X11/misc
}

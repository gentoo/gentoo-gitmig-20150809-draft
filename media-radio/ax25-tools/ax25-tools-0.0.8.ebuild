# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ax25-tools/ax25-tools-0.0.8.ebuild,v 1.1 2003/06/19 18:54:08 rphillips Exp $

DESCRIPTION="XASTIR"
HOMEPAGE="http://xastir.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/ax25/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
        dev-libs/libax25"

src_compile() {
	econf || die
	pmake || die
}

src_install() {
    make DESTDIR=${D} install || die
}


# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/kups/kups-1.0-r1.ebuild,v 1.10 2002/08/01 11:59:03 seemant Exp $

inherit kde-base || die

need-kde 2.1.1

LICENSE="GPL-2"
DESCRIPTION="A CUPS front-end for KDE"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/kups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/kups/"
KEYWORDS="x86"


newdepend ">=net-print/qtcups-2.0"

src_compile() {

	rm configure
	autoconf || die

	CFLAGS="${CFLAGS} -L/usr/X11R6/lib"
	kde_src_compile

}

src_install () {
	make DESTDIR=${D} CUPS_MODEL_DIR=/usr/share/cups/model install
	kde_src_install dodoc
}


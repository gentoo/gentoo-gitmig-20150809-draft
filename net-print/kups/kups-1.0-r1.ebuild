# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/kups/kups-1.0-r1.ebuild,v 1.14 2003/07/22 20:15:29 vapier Exp $

inherit kde-base

need-kde 2.1.1

LICENSE="GPL-2"
DESCRIPTION="A CUPS front-end for KDE"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/kups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/kups/"
KEYWORDS="x86 ~ppc"


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


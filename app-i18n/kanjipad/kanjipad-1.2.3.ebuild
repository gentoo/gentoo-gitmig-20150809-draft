# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kanjipad/kanjipad-1.2.3.ebuild,v 1.5 2004/04/25 15:06:34 usata Exp $

IUSE=""

DESCRIPTION="Japanese handwriting recognition tool"
HOMEPAGE="http://www.gtk.org/~otaylor/kanjipad/"
SRC_URI="ftp://ftp.gtk.org/pub/users/otaylor/kanjipad/${P}.tar.gz"

LICENSE="GPL-2"
DEPEND=">=x11-libs/gtk+-1.2.10-r8
	>=dev-libs/glib-1.2.10-r4"
KEYWORDS="x86"

SLOT="0"

src_compile() {
	mv Makefile Makefile.orig
	sed -e "s/PREFIX=\/usr\/local/PREFIX=\/usr/" Makefile.orig > Makefile

	emake || die
}

src_install () {
	dobin kanjipad kpengine || die
	dodir /usr/share/kanjipad || die
	insinto /usr/share/kanjipad
	doins jdata.dat || die
}

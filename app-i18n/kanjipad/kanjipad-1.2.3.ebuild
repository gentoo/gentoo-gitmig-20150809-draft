# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kanjipad/kanjipad-1.2.3.ebuild,v 1.6 2004/06/24 21:48:25 agriffis Exp $

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

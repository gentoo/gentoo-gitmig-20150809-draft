# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kanjipad/kanjipad-1.2.3.ebuild,v 1.4 2003/07/21 17:23:58 mholzer Exp $

KEYWORDS="x86"
DESCRIPTION="Japanese handwriting recognition tool"
HOMEPAGE="http://www.gtk.org/~otaylor/kanjipad/"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-1.2.10-r8
	>=dev-libs/glib-1.2.10-r4"

SLOT="0"

SRC_URI="ftp://ftp.gtk.org/pub/users/otaylor/kanjipad/${P}.tar.gz"

S=${WORKDIR}/${P}

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

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kanjipad/kanjipad-2.0.0.ebuild,v 1.2 2004/02/22 16:47:03 brad_mssw Exp $

KEYWORDS="~x86 amd64"
DESCRIPTION="Japanese handwriting recognition tool"
HOMEPAGE="http://fishsoup.net/software/kanjipad/"
SRC_URI="http://fishsoup.net/software/kanjipad/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2"

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
	dodoc COPYING ChangeLog README TODO jstroke/README-kanjipad
}

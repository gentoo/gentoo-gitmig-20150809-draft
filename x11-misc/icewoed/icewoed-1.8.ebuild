# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icewoed/icewoed-1.8.ebuild,v 1.3 2004/11/02 14:36:45 phosphan Exp $

DESCRIPTION="IceWM winoptions editor."
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
IUSE=""

DEPEND=">=x11-libs/qt-3.0.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -e 's:/usr/local:/usr:' -i ${PN}.pro || die 'sed failed'
	echo >> ${PN}.pro -e "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}\nQMAKE_CFLAGS_RELEASE += ${CFLAGS}"
}

src_compile () {
	qmake || die
}

src_install () {
	make INSTALL_ROOT="${D}" install || die
	dodoc AUTHORS README TODO ChangeLog
}

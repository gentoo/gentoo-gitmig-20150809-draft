# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icemc/icemc-2.1-r1.ebuild,v 1.2 2004/11/02 14:40:32 phosphan Exp $

DESCRIPTION="IceWM menu/toolbar editor"
HOMEPAGE="http://icecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=">=x11-libs/qt-3.0.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local:/usr:" -i ${PN}.pro || die "sed failed"
	echo >> ${PN}.pro -e "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}\nQMAKE_CFLAGS_RELEASE += ${CFLAGS}"
}

src_compile() {
	addwrite ${QTDIR}/etc/settings
	qmake ${PN}.pro
	emake || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}

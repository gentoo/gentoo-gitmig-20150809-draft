# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icebgset/icebgset-1.3.ebuild,v 1.7 2009/01/11 21:36:43 phosphan Exp $

DESCRIPTION="IceWM background editor"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"

DEPEND="=x11-libs/qt-3*"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local:/usr:" -i ${PN}.pro || die "sed failed"
	echo >> ${PN}.pro -e "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}\nQMAKE_CFLAGS_RELEASE += ${CFLAGS}"
}

src_compile() {
	${QTDIR}/bin/qmake || die
	emake || die
}

src_install() {
	dobin icebgset
	dodoc AUTHORS ChangeLog README
}

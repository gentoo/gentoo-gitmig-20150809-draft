# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icesndcfg/icesndcfg-1.3.ebuild,v 1.11 2008/05/09 13:13:39 phosphan Exp $

IUSE=""

DESCRIPTION="IceWM sound editor."
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"

DEPEND="=x11-libs/qt-3*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc ~amd64"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:/usr/local:/usr:" -i ${PN}.pro || die "sed failed"
	echo >> ${PN}.pro -e "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}\nQMAKE_CFLAGS_RELEASE += ${CFLAGS}"
}

src_compile () {
	addwrite ${QTDIR}/etc/settings
	${QTDIR}/bin/qmake ${PN}.pro
	emake || die
}

src_install () {
	dobin ${PN}
	dodoc AUTHORS ChangeLog
}

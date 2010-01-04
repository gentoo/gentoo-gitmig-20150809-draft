# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-2.9.ebuild,v 1.9 2010/01/04 10:14:10 ssuominen Exp $

EAPI=2

DESCRIPTION="IceWM Control Center (only main program, see icewm-tools for the rest)"
HOMEPAGE="http://icecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/qt:3
	!sys-devel/icecream"

src_prepare() {
	sed -e "s:/usr/local:/usr:" -i ${PN}.pro || die
	echo >> ${PN}.pro -e "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}\nQMAKE_CFLAGS_RELEASE += ${CFLAGS}"
}

src_configure() {
	${QTDIR}/bin/qmake || die
}

src_compile() {
	emake || die
}

src_install() {
	emake INSTALL_ROOT="${D}" install_themes install_help || die
	# avoid pre-stripping, see bug #220094
	dobin icecc icecchelp || die
	dodoc AUTHORS ChangeLog
}

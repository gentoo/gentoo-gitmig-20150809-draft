# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-2.9.ebuild,v 1.8 2008/05/08 12:24:40 phosphan Exp $

inherit eutils

DESCRIPTION="IceWM Control Center (only main program, see icewm-tools for the rest)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""
SLOT="0"

DEPEND="=x11-libs/qt-3*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:/usr/local:/usr:" -i ${PN}.pro || die "sed failed"
	echo >> ${PN}.pro -e "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}\nQMAKE_CFLAGS_RELEASE += ${CFLAGS}"
}

src_compile() {
	${QTDIR}/bin/qmake || die
	emake || die
}

src_install() {
	make INSTALL_ROOT="${D}" install_themes install_help || die
	# avoid pre-stripping, see bug #220094
	dobin icecc icecchelp
	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	einfo "emerge icewm-tools for the control center helper tools"
}

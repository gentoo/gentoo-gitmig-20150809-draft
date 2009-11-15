# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kchmviewer/kchmviewer-3.1_p2-r1.ebuild,v 1.5 2009/11/15 11:57:44 pva Exp $

EAPI="2"

inherit versionator eutils qt3

MY_P=${PN}-$(replace_version_separator 2 '-')
MY_P=${MY_P/p}

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://www.kchmviewer.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/qt:3
	dev-libs/chmlib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc43.patch" #218812
	# broken configure script, assure it doesn't fall back to internal libs
	echo "# We use the external chmlib!" > lib/chmlib/chm_lib.h
	# we sanitise LINGUAS to avoid issues when a user specifies the same
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog FAQ DCOP-bingings README || die "installing docs failed"
	make_desktop_entry ${PN} ${PN} ${PN} "QT;Graphics;Viewer"
}

pkg_postinst() {
	if [[ -f ${ROOT}/usr/share/services/chm.protocol ]]; then
		ewarn "kchmviewer and kdevelop's kio_chm don't work together, bug #260134."
		ewarn "Until we find better solution, if you want to read chm files with ${PN}"
		ewarn "you need to remove ${ROOT}usr/share/services/chm.protocol file manually."
	fi
}

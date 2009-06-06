# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kchmviewer/kchmviewer-3.1_p2-r1.ebuild,v 1.2 2009/06/06 16:40:47 nixnut Exp $

EAPI="2"

ARTS_REQUIRED="never"

LANGS="cs fr ru tr zh_CN"

USE_KEG_PACKAGING="1"

inherit kde versionator

set-kdedir 3.5

MY_P=${PN}-$(replace_version_separator 2 '-')
MY_P=${MY_P/p}

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://www.kchmviewer.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="~amd64 ppc ~x86"
IUSE="kde"

DEPEND="!<app-text/kchmviewer-3.1_p2-r1
	x11-libs/qt:3
	dev-libs/chmlib
	kde? ( kde-base/kdelibs:3.5 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" ) #218812

src_prepare() {
	kde_src_prepare
	# broken configure script, assure it doesn't fall back to internal libs
	echo "# We use the external chmlib!" > lib/chmlib/chm_lib.h
}

src_install() {
	kde_src_install

	dodoc ChangeLog FAQ DCOP-bingings README || die "installing docs failed"
}

pkg_postinst() {
	if [[ -f ${ROOT}/usr/share/services/chm.protocol ]]; then
		ewarn "kchmviewer and kdevelop's kio_chm don't work together, bug #260134."
		ewarn "Until we find better solution, if you want to read chm files with ${PN}"
		ewarn "you need to remove ${ROOT}usr/share/services/chm.protocol file manually."
	fi
}

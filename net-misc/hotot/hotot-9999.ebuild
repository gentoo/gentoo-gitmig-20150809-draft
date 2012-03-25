# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hotot/hotot-9999.ebuild,v 1.2 2012/03/25 22:46:51 xmw Exp $

EAPI=4

PYTHON_DEPEND="gtk? 2"
RESTRICT_PYTHON_ABIS="3.*"

EGIT_REPO_URI="https://github.com/shellex/Hotot.git"

inherit cmake-utils git-2 python

DESCRIPTION="lightweight & open source microblogging client"
HOMEPAGE="http://hotot.org"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="chrome gtk kde qt4"

RDEPEND="
	gtk? ( dev-python/pywebkitgtk )
	qt4? ( x11-libs/qt-webkit:4 )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use_with chrome CHROME) \
		$(cmake-utils_use_with gtk GTK) \
		$(cmake-utils_use_with kde KDE) \
		$(cmake-utils_use_with qt4 QT) \
		-DPYTHON_EXECUTABLE=$(PYTHON -2 -a)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	find "${D}" -name "*.pyc" -delete
}

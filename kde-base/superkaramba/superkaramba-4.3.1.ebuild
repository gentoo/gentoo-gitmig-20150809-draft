# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-4.3.1.ebuild,v 1.3 2009/10/18 16:41:45 maekke Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 x86"
IUSE="debug +handbook python"

DEPEND="
	kde-base/qimageblitz
	python? ( >=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	python? ( >=kde-base/krosspython-${PV}:${SLOT}[kdeprefix=] )
"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_configure
}

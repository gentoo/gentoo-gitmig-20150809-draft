# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kommander/kommander-4.2.1.ebuild,v 1.2 2009/03/12 11:36:55 scarabeus Exp $

EAPI="2"

KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="tidy"

DEPEND=">=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tidy LibTidy)"
	kde4-meta_src_configure
}

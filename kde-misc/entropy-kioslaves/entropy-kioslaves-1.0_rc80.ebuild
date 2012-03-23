# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/entropy-kioslaves/entropy-kioslaves-1.0_rc80.ebuild,v 1.2 2012/03/23 16:24:15 lxnay Exp $

EAPI="3"
KDE_MINIMAL="4.2"
CMAKE_REQUIRED=never
inherit eutils kde4-base

DESCRIPTION="Entropy Package Manager KDE kioslaves support"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"

S="${WORKDIR}/entropy-${PV}"

RDEPEND=">=app-admin/sulfur-${PV}"
DEPEND="${RDEPEND}"

src_prepare() {
	einfo "nothing to prepare"
}

src_configure() {
	einfo "nothing to configure"
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	dodir "/${KDEDIR}/share/kde4/services/"
	insinto "/${KDEDIR}/share/kde4/services/"
	doins "${S}/sulfur/misc/entropy.protocol"
}

pkg_postinst() {
	kde4-base_pkg_postinst
}

pkg_postrm() {
	kde4-base_pkg_postrm
}

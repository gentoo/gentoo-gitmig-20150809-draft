# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepimlibs/kdepimlibs-4.0.0.ebuild,v 1.2 2008/01/20 16:40:26 ingmar Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="Common library for KDE PIM apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="ldap sasl"
LICENSE="GPL-2 LGPL-2"
RESTRICT="test"

DEPEND="
	>=app-crypt/gpgme-1.1.6
	dev-libs/boost
	dev-libs/libgpg-error
	ldap? ( >=net-nds/openldap-2 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with ldap Ldap)
		$(cmake-utils_use_with sasl Sasl2)"
	kde4-base_src_compile
}

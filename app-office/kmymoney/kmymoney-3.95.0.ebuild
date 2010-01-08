# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney/kmymoney-3.95.0.ebuild,v 1.3 2010/01/08 22:05:23 ssuominen Exp $

EAPI=2
inherit flag-o-matic kde4-base

DESCRIPTION="A personal finance manager for KDE"
HOMEPAGE="http://sourceforge.net/projects/kmymoney2/"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug quotes test"

# Next alpha will have configure opts to make some of these optional.
COMMON_DEPEND=">=dev-libs/boost-1.33.1
	>=net-libs/aqbanking-4.2[qt4]
	>=sys-libs/gwenhywfar-3.10
	dev-libs/libxml2
	dev-libs/libical
	dev-libs/libgpg-error
	app-crypt/gpgme
	>=dev-libs/libofx-0.9
	>=kde-base/libkleo-${KDE_MINIMAL}
	>=kde-base/kdepimlibs-${KDE_MINIMAL}"
RDEPEND="${COMMON_DEPEND}
	quotes? ( dev-perl/Finance-Quote )"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-util/cppunit-1.12 )"

DOCS="AUTHORS BUGS ChangeLog* README* TODO"

# Doesn't compile with -j9, reported to upstream.
MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	# Doesn't link with -Wl,--as-needed, reported to upstream.
	append-ldflags $(no-as-needed)

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use test KDE4_BUILD_TESTS)"
	kde4-base_src_configure
}

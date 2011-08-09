# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-4.6.5-r1.ebuild,v 1.2 2011/08/09 17:12:15 hwoarang Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdeutils"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE calculator"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-libs/gmp
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-4.3.2-solaris-knumber_priv.patch
	"${FILESDIR}"/${P}-fix-kbd-ui.patch
)

src_test() {
	LANG=C kde4-meta_src_test
}

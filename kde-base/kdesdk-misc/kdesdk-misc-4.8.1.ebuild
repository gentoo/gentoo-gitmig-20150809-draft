# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-4.8.1.ebuild,v 1.2 2012/04/04 18:00:21 ago Exp $

EAPI=4

KMNAME="kdesdk"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="KDE miscellaneous SDK tools"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug extras"

DEPEND="
	extras? ( >=dev-java/antlr-2.7.7:0[cxx,script] )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	doc/kmtrace/
	doc/poxml/
	kmtrace/
	kpartloader/
	kprofilemethod/
	kspy/
	kunittest/
	poxml/
	scheck/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with extras Antlr2)
	)

	kde4-meta_src_configure
}

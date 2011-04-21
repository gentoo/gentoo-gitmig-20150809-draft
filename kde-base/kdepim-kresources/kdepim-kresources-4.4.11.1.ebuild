# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kresources/kdepim-kresources-4.4.11.1.ebuild,v 1.1 2011/04/21 21:24:13 dilfridge Exp $

EAPI=4

KDE_MINIMAL="4.6"
KMNAME="kdepim"
KMMODULE="kresources"
inherit kde4-meta

DESCRIPTION="KDE PIM groupware plugin collection"
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	korganizer/version.h
"

KMLOADLIBS="libkdepim"

src_install() {
	kde4-meta_src_install

	# Install headers needed by kdepim-wizards, egroupware stuff gone
	insinto "${PREFIX}"/include/${PN}
	doins "${CMAKE_BUILD_DIR}"/${KMMODULE}/{groupwise,slox}/*.h
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kresources/kdepim-kresources-4.3.5.ebuild,v 1.5 2010/06/21 15:52:57 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
KMMODULE="kresources"
inherit kde4-meta

DESCRIPTION="KDE PIM groupware plugin collection"
IUSE="debug"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"

DEPEND="
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep kaddressbook)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kaddressbook/common/
	kmail/
	knotes/
	korganizer/version.h
"

KMLOADLIBS="libkdepim"

src_prepare() {
	local kconfig_compiler="${EKDEDIR}/bin/kconfig_compiler"

	pushd kaddressbook/common
	# create the kabprefs_base.h file
	"${kconfig_compiler}" kaddressbook.kcfg kabprefs_base.kcfgc
	popd

	kde4-meta_src_prepare
}

src_install() {
	kde4-meta_src_install

	# Install headers needed by kdepim-wizards
	insinto "${KDEDIR}"/include/${PN}
	doins "${CMAKE_BUILD_DIR}"/${KMMODULE}/{groupwise,egroupware,slox}/*.h || \
			die "Failed to install extra header files"
}

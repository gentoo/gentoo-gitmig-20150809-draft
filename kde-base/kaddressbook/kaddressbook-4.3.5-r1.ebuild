# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook/kaddressbook-4.3.5-r1.ebuild,v 1.2 2010/06/21 15:53:43 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="The KDE Address Book"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook gnokii"

DEPEND="
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	gnokii? ( app-mobilephone/gnokii )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	plugins/ktexteditor/
"
# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kmail/
	libkleo/
"
KMLOADLIBS="libkdepim libkleo"

src_prepare() {
	kde4-meta_src_prepare

	sed -n -e '/qt4_generate_dbus_interface(.*org\.kde\.kmail\.\(kmail\|mailcomposer\)\.xml/p' \
		-e '/add_custom_target(kmail_xml /,/)/p' \
		-i kmail/CMakeLists.txt || die "uncommenting xml failed"
	_change_cmakelists_parent_dirs kmail
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with gnokii)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# install additional generated header that is needed by kresources
	insinto "${KDEDIR}"/include/${PN}
	doins "${CMAKE_BUILD_DIR}"/${PN}/common/kabprefs_base.h || \
		die "Failed to install extra header files"
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-4.3.4.ebuild,v 1.4 2010/01/19 04:55:20 abcd Exp $

EAPI="2"

KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Environment setting required for all KDE4 apps to run."
HOMEPAGE="http://kde.org"
[[ ${PV} = *9999* ]] && ESVN_REPO_URI="" || SRC_URI=""

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE=""

add_blocker kdelibs 4.2.2-r1 '<3.5.10-r3:3.5' 4.2.70:4.3

src_unpack() {
	:
}

src_prepare() {
	:
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	if use kdeprefix; then
		# List all the multilib libdirs
		local _libdir _libdirs
		for _libdir in $(get_all_libdirs); do
			_libdirs+=":${EKDEDIR}/${_libdir}"
		done
		_libdirs=${_libdirs#:}

		# number goes down with version
		cat <<-EOF > "${T}/43kdepaths-${SLOT}"
PATH="${EKDEDIR}/bin"
ROOTPATH="${EKDEDIR}/sbin:${EKDEDIR}/bin"
LDPATH="${_libdirs}"
MANPATH="${EKDEDIR}/share/man"
CONFIG_PROTECT="${EKDEDIR}/share/config ${EKDEDIR}/env ${EKDEDIR}/shutdown ${EPREFIX}/usr/share/config"
#KDE_IS_PRELINKED=1
PKG_CONFIG_PATH="${EKDEDIR}/$(get_libdir)/pkgconfig"
XDG_DATA_DIRS="${EKDEDIR}/share"
EOF
		doenvd "${T}/43kdepaths-${SLOT}"
		cat <<-EOF > "${T}/50-kde-${SLOT}"
SEARCH_DIRS="${EKDEDIR}/bin ${EKDEDIR}/lib*"
EOF
		insinto /etc/revdep-rebuild
		doins "${T}/50-kde-${SLOT}"

		# kdeglobals needed to make third party apps installed in /usr work
		cat <<-EOF > "${T}/kdeglobals"
[Directories][\$i]
prefixes=${EPREFIX}/usr
EOF
		insinto ${KDEDIR}/share/config
		doins "${T}/kdeglobals"
	else
		# Much simpler for the FHS compliant -kdeprefix install
		# number goes down with version
		cat <<-EOF > "${T}/43kdepaths"
CONFIG_PROTECT="${EPREFIX}/usr/share/config"
#KDE_IS_PRELINKED=1
EOF
		doenvd "${T}/43kdepaths"
	fi
}

pkg_preinst() {
	:
}

src_test() {
	:
}

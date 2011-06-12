# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-4.6.2.ebuild,v 1.6 2011/06/12 22:54:49 abcd Exp $

EAPI=3

CMAKE_REQUIRED="never"
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Environment setting required for all KDE4 apps to run."
HOMEPAGE="http://kde.org"
[[ ${PV} = *9999* ]] && ESVN_REPO_URI="" || SRC_URI=""

KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE="aqua"

add_blocker kdelibs 4.2.2-r1 '<3.5.10-r3:3.5' 4.2.70:4.3

S=${WORKDIR}

src_unpack() {
	:
}

src_prepare() {
	:
}

src_install() {
	# number goes down with version
	cat <<-EOF > 43kdepaths
CONFIG_PROTECT="/usr/share/config"
#KDE_IS_PRELINKED=1
EOF
	doenvd 43kdepaths

	# Properly place xinitrc.d file that exports XDG_MENU_PREFIX to env
	cat <<EOF > 11-xdg-menu-kde-$(get_kde_version)
#!/bin/sh

if [ -z \${XDG_MENU_PREFIX} ] && [ "\${DESKTOP_SESSION}" = "KDE-4" ]; then
	export XDG_MENU_PREFIX="kde-$(get_kde_version)-"
fi
EOF
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe 11-xdg-menu-kde-$(get_kde_version) || die "doexe failed"
}

pkg_preinst() {
	:
}

src_test() {
	:
}

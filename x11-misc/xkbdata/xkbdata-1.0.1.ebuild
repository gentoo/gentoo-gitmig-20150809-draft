# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbdata/xkbdata-1.0.1.ebuild,v 1.13 2009/05/05 17:39:17 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

MODULE="data"
inherit x-modular multilib

DESCRIPTION="X.Org xkbdata data"
KEYWORDS="alpha amd64 arm hppa mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-apps/xkbcomp
	!x11-misc/xkeyboard-config"
DEPEND="${RDEPEND}"

pkg_setup() {
	# (#130590) The old XKB directory can screw stuff up
	local DIR="${ROOT}usr/$(get_libdir)/X11/xkb"
	if [[ -d ${DIR} ]] ; then
		eerror "Directory ${DIR} should be"
		eerror "manually deleted/renamed/relocated before installing!"
		die "Manually remove ${DIR}"
	fi
}

src_install() {
	x-modular_src_install
	keepdir /var/lib/xkb
	dosym ../../../../var/lib/xkb /usr/share/X11/xkb/compiled
	echo "CONFIG_PROTECT=\"/usr/share/X11/xkb\"" > ${T}/10xkbdata
	doenvd "${T}"/10xkbdata
}

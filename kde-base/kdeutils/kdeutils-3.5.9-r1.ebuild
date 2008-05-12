# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.5.9-r1.ebuild,v 1.5 2008/05/12 17:38:35 ranger Exp $

EAPI="1"
inherit kde-dist eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-02.tar.bz2"

DESCRIPTION="KDE utilities."

KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ppc ppc64 sparc ~x86"
IUSE="crypt kdehiddenvisibility pbbuttonsd snmp xscreensaver"

BOTH_DEPEND="~kde-base/kdebase-${PV}
		snmp? ( net-analyzer/net-snmp )
		pbbuttonsd? ( app-laptop/pbbuttonsd )
		dev-lang/python
		dev-libs/gmp
		x11-libs/libXtst"

RDEPEND="${BOTH_DEPEND}
		crypt? ( app-crypt/gnupg
				app-crypt/pinentry )"

DEPEND="${BOTH_DEPEND}
		xscreensaver? ( x11-libs/libXScrnSaver )
		x11-libs/libX11
		x11-proto/xproto
		virtual/os-headers"

PATCHES=( "${FILESDIR}/superkaramba-3.5.7-network_sensor.patch"
			"${FILESDIR}/kmilo-${PV}-fixpaths.patch" )
EPATCH_EXCLUDE="klaptopdaemon-3.5-suspend2+xsession-errors.diff
				klaptopdaemon-3.5-lock-and-hibernate.diff"

pkg_setup() {
	if use crypt && ! built_with_use app-crypt/pinentry gtk && ! built_with_use app-crypt/pinentry qt3 ; then
		eerror "kgpg needs app-crypt/pinentry built with either the gtk or qt3 USE flag."
		eerror "Please enable either USE flag and re-install app-crypt/pinentry."
		die "app-crypt/pinentry needs to be rebuilt with gtk or qt3 support."
	fi

	kde_pkg_setup
}

src_unpack() {
	kde_src_unpack

	# Fix some desktop files
	sed -i -e "s:Hidden=true:Hidden=false:" "${S}/ksim/ksim.desktop" \
		|| die "sed (ksim) failed"
	sed -i -e "s:\(^Type=\)Service:\1Application:" "${S}/kdelirc/irkick/irkick.desktop" \
		|| die "sed (irkick) failed"
	sed -i -e "s:\(^Init=.*\):X-\1:" "${S}/klaptopdaemon/applnk/laptop.desktop" \
		|| die "sed (laptop) failed"
}

src_compile() {
	local myconf="$(use_with snmp)
				$(use_with pbbuttonsd powerbook)
				$(use_with xscreensaver)
				--without-xmms"

	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}

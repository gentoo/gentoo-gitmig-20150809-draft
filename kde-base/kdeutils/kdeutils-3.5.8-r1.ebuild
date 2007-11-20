# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.5.8-r1.ebuild,v 1.1 2007/11/20 13:46:02 philantrop Exp $

inherit kde-dist eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-02.tar.bz2"

DESCRIPTION="KDE utilities."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt kdehiddenvisibility pbbuttonsd snmp xscreensaver"

BOTH_DEPEND="~kde-base/kdebase-${PV}
		snmp? ( net-analyzer/net-snmp )
		pbbuttonsd? ( app-laptop/pbbuttonsd )
		dev-lang/python
		dev-libs/gmp
		x11-libs/libXtst"

RDEPEND="${BOTH_DEPEND}
		crypt? ( app-crypt/gnupg )"

DEPEND="${BOTH_DEPEND}
		xscreensaver? ( x11-libs/libXScrnSaver )
		x11-libs/libX11
		x11-proto/xproto
		virtual/os-headers"

PATCHES="${FILESDIR}/superkaramba-3.5.7-network_sensor.patch
		${FILESDIR}/klaptopdaemon-3.5.7-has_acpi_sleep.patch
		${FILESDIR}/kmilo-3.5.8-198015_XF86Audio.patch"
EPATCH_EXCLUDE="klaptopdaemon-3.5-suspend2+xsession-errors.diff
				klaptopdaemon-3.5-lock-and-hibernate.diff"

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

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.4.3-r1.ebuild,v 1.9 2006/04/04 01:33:43 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="crypt snmp pbbuttonsd"

DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )
	pbbuttonsd? ( app-laptop/pbbuttonsd )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

src_unpack() {
	kde_src_unpack

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdeutils-3.4-configure.patch"

	# Fix output of klaptopdaemon (kde bug 103437).
	epatch "${FILESDIR}/kdeutils-3.4.3-klaptopdaemon.patch"

	# For the configure patch.
	make -f admin/Makefile.common || die
}

src_compile() {
	local myconf="$(use_with snmp) $(use_with pbbuttonsd powerbook)"

	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}

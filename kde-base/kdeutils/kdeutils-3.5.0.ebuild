# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.5.0.ebuild,v 1.1 2005/11/22 22:14:05 danarmak Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crypt snmp pbbuttonsd xmms"

DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )
	pbbuttonsd? ( app-laptop/pbbuttonsd )
	dev-lang/python
	xmms? ( media-sound/xmms )
	dev-libs/gmp"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )
	!x11-misc/superkaramba"

src_unpack() {
	kde_src_unpack

	# Fix output of klaptopdaemon (kde bug 103437).
	epatch "${FILESDIR}/kdeutils-3.4.3-klaptopdaemon.patch"
}

src_compile() {
	local myconf="$(use_with snmp) $(use_with pbbuttonsd powerbook)
	              $(use_with xmms)"

	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}

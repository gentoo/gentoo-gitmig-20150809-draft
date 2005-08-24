# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.5_alpha1.ebuild,v 1.1 2005/08/24 23:18:55 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crypt snmp pbbuttonsd xmms"

DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )
	pbbuttonsd? ( app-laptop/pbbuttonsd )
	dev-lang/python
	xmms? ( media-sound/xmms )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )
	!x11-misc/superkaramba"

src_compile() {
	local myconf="$(use_with snmp) $(use_with pbbuttonsd powerbook)
	              $(use_with xmms)"

	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}

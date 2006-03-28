# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmilo/kmilo-3.5.1.ebuild,v 1.2 2006/03/28 00:16:40 agriffis Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kmilo - a kded module that can be extended to support various types of hardware
input devices that exist, such as those on keyboards."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="pbbuttonsd"
DEPEND="pbbuttonsd? ( app-laptop/pbbuttonsd )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with pbbuttonsd powerbook)"

	kde-meta_src_compile
}

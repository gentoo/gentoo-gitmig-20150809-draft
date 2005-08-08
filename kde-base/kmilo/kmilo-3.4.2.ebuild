# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmilo/kmilo-3.4.2.ebuild,v 1.5 2005/08/08 22:02:40 kloeri Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kmilo - a kded module that can be extended to support various types of hardware
input devices that exist, such as those on keyboards."
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="pbbuttonsd"
DEPEND="pbbuttonsd? (app-laptop/pbbuttonsd)"
RDEPEND="pbbuttonsd?  (app-laptop/pbbuttonsd)"

PATCHES="$FILESDIR/configure-fix-kdeutils-powerbook.patch"

src_compile() {
	local myconf="$(use_with pbbuttonsd powerbook)"

	kde-meta_src_compile
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/prism54-firmware/prism54-firmware-1.0.4.3.ebuild,v 1.1 2005/01/03 16:03:19 genstef Exp $

DESCRIPTION="Firmware for Intersil Prism GT / Prism Duette wireless chipsets"
HOMEPAGE="http://prism54.org/"
RESTRICT="nomirror"
SRC_URI="http://prism54.org/~mcgrof/firmware/${PV}.arm"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=sys-apps/hotplug-20040923
		!net-wireless/prism54"

src_install() {
	insinto /lib/firmware/
	newins ${DISTDIR}/${PV}.arm isl3890
}

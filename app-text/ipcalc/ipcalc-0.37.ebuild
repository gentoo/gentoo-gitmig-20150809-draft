# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ipcalc/ipcalc-0.37.ebuild,v 1.2 2004/09/16 01:35:03 pvdabeel Exp $

MY_PN="ipcalc"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ipcalc takes an IP address and netmask and calculates the resulting broadcast, network, Cisco wildcard mask, and host range."
HOMEPAGE="http://jodies.de/ipcalc"
SRC_URI="http://jodies.de/ipcalc-archive/${MY_P}.tar.gz"

DEPEND=">=dev-lang/perl-5.6.0"
KEYWORDS="~x86 ~hppa ~amd64 ~sparc ~mips ~macos ~ppc64 ~alpha ~ppc-macos"
IUSE=""
SLOT="0"
LICENSE="as-is"

src_install () {
	newbin ${MY_PN} ${MY_PN}
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ipcalc/ipcalc-0.37.ebuild,v 1.5 2004/11/02 14:53:52 vapier Exp $

MY_PN="ipcalc"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="calculates broadcast/network/etc... from an IP address and netmask"
HOMEPAGE="http://jodies.de/ipcalc"
SRC_URI="http://jodies.de/ipcalc-archive/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.0"

src_install () {
	newbin ${MY_PN} ${MY_PN} || die
}

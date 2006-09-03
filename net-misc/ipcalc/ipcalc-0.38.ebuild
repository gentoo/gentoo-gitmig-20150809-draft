# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipcalc/ipcalc-0.38.ebuild,v 1.1 2006/09/03 21:01:54 kumba Exp $

DESCRIPTION="calculates broadcast/network/etc... from an IP address and netmask"
HOMEPAGE="http://jodies.de/ipcalc"
SRC_URI="http://jodies.de/ipcalc-archive/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.0"

src_install () {
	dobin ${PN} || die
	dodoc changelog
}

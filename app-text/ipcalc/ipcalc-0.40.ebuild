# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ipcalc/ipcalc-0.40.ebuild,v 1.9 2006/07/20 21:08:03 flameeyes Exp $

DESCRIPTION="calculates broadcast/network/etc... from an IP address and netmask"
HOMEPAGE="http://jodies.de/ipcalc"
SRC_URI="http://jodies.de/ipcalc-archive/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.0"

src_install () {
	dobin ${PN} || die
	dodoc changelog
}

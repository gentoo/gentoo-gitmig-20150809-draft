# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-kernelcookies/fortune-mod-kernelcookies-8.ebuild,v 1.1 2004/06/22 03:08:27 vapier Exp $

DESCRIPTION="A collection of funny lines from the Linux kernel"
HOMEPAGE="http://www.schwarzvogel.de/software-misc.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/kernelcookies-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/kernelcookies-${PV}

src_install() {
	insinto /usr/share/fortune
	doins kernelcookies.dat kernelcookies
}

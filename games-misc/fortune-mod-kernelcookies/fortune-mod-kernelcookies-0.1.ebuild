# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-kernelcookies/fortune-mod-kernelcookies-0.1.ebuild,v 1.5 2004/02/20 06:43:58 mr_bones_ Exp $

DESCRIPTION="A collection of funny lines from the Linux kernel"
HOMEPAGE="http://unattached.i-no.de/software-misc.shtml"
SRC_URI="http://unattached.i-no.de/pkgs/kernelcookies.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/kernelcookies

src_install() {
	insinto /usr/share/fortune
	doins kernelcookies.dat kernelcookies
}

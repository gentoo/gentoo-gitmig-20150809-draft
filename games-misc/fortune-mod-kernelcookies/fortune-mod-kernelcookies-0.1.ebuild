# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-kernelcookies/fortune-mod-kernelcookies-0.1.ebuild,v 1.1 2003/09/10 18:14:04 vapier Exp $

S=${WORKDIR}/kernelcookies
DESCRIPTION="A collection of funny lines from the Linux kernel"
SRC_URI="http://unattached.i-no.de/pkgs/kernelcookies.tar.gz"
HOMEPAGE="http://unattached.i-no.de/software-misc.shtml"

SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="app-games/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins kernelcookies.dat kernelcookies
}

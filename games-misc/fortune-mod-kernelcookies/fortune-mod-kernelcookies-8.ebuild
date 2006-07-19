# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-kernelcookies/fortune-mod-kernelcookies-8.ebuild,v 1.7 2006/07/19 19:53:08 flameeyes Exp $

inherit eutils

DESCRIPTION="A collection of funny lines from the Linux kernel"
HOMEPAGE="http://www.schwarzvogel.de/software-misc.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/kernelcookies-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="offensive"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/kernelcookies-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug #64985
	if ! use offensive ; then
		rm -f *.dat
		epatch "${FILESDIR}"/${PV}-offensive.patch
		strfile -s kernelcookies || die
	fi
}

src_install() {
	insinto /usr/share/fortune
	doins kernelcookies.dat kernelcookies || die
}

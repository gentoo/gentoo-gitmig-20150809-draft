# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nvram-wakeup/nvram-wakeup-0.97.ebuild,v 1.1 2004/10/08 04:03:44 vapier Exp $

inherit flag-o-matic

DESCRIPTION="read and write the WakeUp time in the BIOS"
HOMEPAGE="http://sourceforge.net/projects/nvram-wakeup"
SRC_URI="mirror://sourceforge/nvram-wakeup/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	# Need to be careful with CFLAGS since this could eat your bios
	strip-flags
	sed -i \
		-e "s:-O2 -Wall -Wstrict-prototypes -g -mcpu=i686:${CFLAGS} -g:" \
		Makefile || die "setting CFLAGS"
}

src_install() {
	make \
		prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${PF} \
		install || die
	prepalldocs
}

pkg_postinst() {
	echo
	ewarn "WARNING:"
	ewarn "This program  writes into the  NVRAM  (used by  BIOS to store the CMOS"
	ewarn "settings).  This is  DANGEROUS.  Do it at  your own  risk.  Neither the"
	ewarn "author  of  this program  (nvram-wakeup)  nor anyone else  can be made"
	ewarn "responsible to any damage made by this program in any way."
	ewarn "(The worst case  happened to me is that on reboot the BIOS noticed the"
	ewarn "illegal  contents of  the nvram and  set everything to default values."
	ewarn "But this doesn't mean that you can't destroy even your whole computer.)"
	echo
	ewarn "		YOU HAVE BEEN WARNED, HAVE A NICE DAY"
	echo
}

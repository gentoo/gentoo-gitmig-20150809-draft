# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/app-arch/flexbackup/flexbackup-1.0.3.ebuild,v 1.1 2003/04/16 12:25:49 mholzer Exp $

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Flexible backup script using perl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://flexbackup.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/glibc"
RDEPEND="app-arch/afio
	app-arch/mt-st
	app-arch/dump
	sys-apps/findutils
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	epatch ${FILESDIR}/Makefile-gentoo.diff
	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems). Try emake first. It might
	# not work for some packages, in which case you'll have to resort
	# to normal "make".
	emake || die
	#make || die
}

src_install() {
	dodir /etc
	dodir /usr/bin
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING CREDITS FAQ INSTALL README TODO
}

pkg_postinst() {
	einfo ""
	einfo "now edit your /etc/${PN}.conf"
	einfo "if you are using devfs, the tape device"
	einfo "should be set to /dev/tapes/tape0/mtn"
	einfo ""
}

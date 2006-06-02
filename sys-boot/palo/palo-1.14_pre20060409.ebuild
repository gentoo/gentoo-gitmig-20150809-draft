# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/palo/palo-1.14_pre20060409.ebuild,v 1.3 2006/06/02 20:51:52 gmsoft Exp $

inherit eutils

MY_V=${PV/_pre/-CVS}
DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/"
SRC_URI="http://ftp.parisc-linux.org/cvs/palo-${MY_V}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* hppa"
IUSE=""

DEPEND="virtual/libc"
PROVIDE="virtual/bootloader"

S=${WORKDIR}/palo

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-remove-HOME-TERM.patch
}

src_compile() {
	emake -C palo CFLAGS="${CFLAGS} -I../include -I../lib -D__KERNEL_STRICT_NAMES" || die "make palo failed."
	emake -C ipl CFLAGS="${CFLAGS} -I. -I../lib -I../include -mdisable-fpregs -Wall -D__kernel_timer_t=int -D__kernel_clockid_t=int" || die "make ipl failed."
	emake MACHINE=parisc iplboot || die "make iplboot failed."
}

src_install() {
	dosbin palo/palo || die
	doman palo.8
	dohtml README.html
	dodoc README palo.conf

	insinto /etc
	doins ${FILESDIR}/palo.conf

	insinto /usr/share/palo
	doins iplboot
}

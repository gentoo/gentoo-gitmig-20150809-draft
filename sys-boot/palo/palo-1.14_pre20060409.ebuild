# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/palo/palo-1.14_pre20060409.ebuild,v 1.4 2006/07/08 15:28:55 vapier Exp $

inherit eutils flag-o-matic

MY_V=${PV/_pre/-CVS}
DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/"
SRC_URI="http://ftp.parisc-linux.org/cvs/palo-${MY_V}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* hppa"
IUSE=""

DEPEND=""
PROVIDE="virtual/bootloader"

S=${WORKDIR}/palo

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-remove-HOME-TERM.patch
	epatch "${FILESDIR}"/${PN}-1.14-build.patch
}

src_compile() {
	append-flags -D__KERNEL_STRICT_NAMES
	emake -C palo || die "make palo failed"
	append-flags -D__kernel_timer_t=int -D__kernel_clockid_t=int
	emake -C ipl || die "make ipl failed"
	emake MACHINE=parisc iplboot || die "make iplboot failed."
}

src_install() {
	into /
	dosbin palo/palo || die
	doman palo.8
	dohtml README.html
	dodoc README palo.conf

	insinto /etc
	doins "${FILESDIR}"/palo.conf || die

	insinto /usr/share/palo
	doins iplboot || die
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setserial/setserial-2.17-r2.ebuild,v 1.19 2003/12/17 04:06:27 brad_mssw Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Configure your serial ports with it"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz
	 ftp://ftp.sunsite.org.uk/Mirrors/tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz"
HOMEPAGE="http://setserial.sourceforge.net/"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	pmake setserial || die
}

src_install() {
	doman setserial.8
	into /
	dobin setserial

	dodoc README
	docinto txt
	dodoc Documentation/*
	insinto /etc
	doins serial.conf
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setserial/setserial-2.17-r2.ebuild,v 1.26 2004/11/15 18:59:41 vapier Exp $

DESCRIPTION="Configure your serial ports with it"
HOMEPAGE="http://setserial.sourceforge.net/"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz
	 ftp://ftp.sunsite.org.uk/Mirrors/tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake setserial || die
}

src_install() {
	doman setserial.8
	into /
	dobin setserial || die

	dodoc README
	docinto txt
	dodoc Documentation/*
	insinto /etc
	doins serial.conf
}

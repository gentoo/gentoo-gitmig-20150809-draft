# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setserial/setserial-2.17-r3.ebuild,v 1.3 2010/10/08 02:16:31 leio Exp $

inherit eutils

DESCRIPTION="Configure your serial ports with it"
HOMEPAGE="http://setserial.sourceforge.net/"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz
	 ftp://ftp.sunsite.org.uk/Mirrors/tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-spelling.patch
	epatch "${FILESDIR}"/${P}-manpage-updates.patch
	epatch "${FILESDIR}"/${P}-headers.patch
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	econf || die
	emake setserial || die
}

src_install() {
	doman setserial.8
	into /
	dobin setserial || die

	insinto /etc
	doins serial.conf
	doinitd "${FILESDIR}"/serial

	dodoc README
	docinto txt
	dodoc Documentation/*
}

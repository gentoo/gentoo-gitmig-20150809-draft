# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/flexbackup/flexbackup-1.2.0.ebuild,v 1.4 2003/09/20 20:33:54 aliz Exp $

inherit eutils

DESCRIPTION="Flexible backup script using perl"
HOMEPAGE="http://flexbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/flexbackup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND="app-arch/afio
	app-arch/mt-st
	app-arch/dump
	sys-apps/findutils
	dev-lang/perl"

src_compile() {
	epatch ${FILESDIR}/Makefile-gentoo.diff
	emake || die
}

src_install() {
	dodir /etc
	dodir /usr/bin
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING CREDITS INSTALL README TODO
	dohtml faq.html
}

pkg_postinst() {
	einfo ""
	einfo "now edit your /etc/${PN}.conf"
	einfo "if you are using devfs, the tape device"
	einfo "should be set to /dev/tapes/tape0/mtn"
	einfo ""
}

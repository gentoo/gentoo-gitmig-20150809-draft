# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/app-arch/flexbackup/flexbackup-1.0.4.ebuild,v 1.1 2003/06/24 22:28:04 mholzer Exp $

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

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/flexbackup/flexbackup-1.2.0-r1.ebuild,v 1.4 2003/09/03 19:02:55 max Exp $

DESCRIPTION="Flexible backup script using perl."
HOMEPAGE="http://flexbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-lang/perl
	sys-apps/findutils
	sys-apps/tar
	app-arch/mt-st"

src_compile() {
	emake BINPATH="/usr/bin" || die "compile problem"
}

src_install() {
	dodir /etc /usr/bin
	einstall CONFFILE="${D}/etc/flexbackup.conf" BINPATH="${D}/usr/bin"

	dosed "/^\$type = /s:'afio':'tar':" /etc/flexbackup.conf
	dosed "/^\$buffer = /s:'buffer':'false':" /etc/flexbackup.conf

	dodoc CHANGES COPYING CREDITS INSTALL README TODO
	dohtml faq.html
}

pkg_postinst() {
	einfo "Please edit your /etc/flexbackup.conf file to suit your"
	einfo "needs.  If you are using devfs, the tape device should"
	einfo "be set to /dev/tapes/tape0/mtn.  If you need to use any"
	einfo "archiver other than tar, please emerge it separately."
	echo
}

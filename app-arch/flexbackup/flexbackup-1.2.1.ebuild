# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/flexbackup/flexbackup-1.2.1.ebuild,v 1.8 2005/02/03 15:59:24 luckyduck Exp $

DESCRIPTION="Flexible backup script using perl"
HOMEPAGE="http://flexbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 hppa ~amd64"
IUSE=""

RDEPEND="dev-lang/perl
	sys-apps/findutils
	app-arch/tar
	app-arch/mt-st"

src_compile() {
	emake BINPATH="/usr/bin" || die "compile problem"
}

src_install() {
	dodir /etc /usr/bin /usr/share/man/man{1,5}
	einstall BINPATH="${D}/usr/bin" CONFFILE="${D}/etc/flexbackup.conf" \
		MANPATH="${D}/usr/share/man"

	dosed "/^\$type = /s:'afio':'tar':" /etc/flexbackup.conf
	dosed "/^\$buffer = /s:'buffer':'false':" /etc/flexbackup.conf

	dodoc CHANGES CREDITS INSTALL README TODO
	dohtml faq.html
}

pkg_postinst() {
	einfo "Please edit your /etc/flexbackup.conf file to suit your"
	einfo "needs.  If you are using devfs, the tape device should"
	einfo "be set to /dev/tapes/tape0/mtn.  If you need to use any"
	einfo "archiver other than tar, please emerge it separately."
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.5.9-r1.ebuild,v 1.12 2003/08/05 14:25:57 vapier Exp $

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND=">=dev-libs/popt-1.5"

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
	make || die
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc examples/logrotate*
}

pkg_postinst() {
	einfo "If you wish to have logrotate e-mail you updates, please"
	einfo "emerge net-mail/mailx"
}

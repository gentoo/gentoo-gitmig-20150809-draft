# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.6.5.ebuild,v 1.5 2003/03/25 05:16:51 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz
	selinux? http://www.nsa.gov/selinux/patches/${P}-2003011510.patch.gz"
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"

IUSE="selinux"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha"
inherit eutils

DEPEND=">=dev-libs/popt-1.5
	selinux? ( >=sys-apps/selinux-small-2003011510-r2 )"

src_compile() {
	use selinux && epatch ${DISTDIR}/${P}-2003011510.patch.gz

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

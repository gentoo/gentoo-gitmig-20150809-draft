# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.6.5-r1.ebuild,v 1.1 2003/05/14 03:31:18 msterret Exp $

IUSE="selinux"

S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz
	selinux? http://www.nsa.gov/selinux/patches/${P}-2003011510.patch.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=dev-libs/popt-1.5
	>=sys-apps/sed-4
	selinux? ( >=sys-apps/selinux-small-2003011510-r2 )"

src_compile() {
	use selinux && epatch ${DISTDIR}/${P}-2003011510.patch.gz

	sed -i \
		-e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" \
		-e "/CVSROOT =/d" \
		Makefile || die "sed failed"

	emake || die "emake failed"
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc examples/logrotate*

	exeinto /etc
	doexe ${FILESDIR}/logrotate.cron

	insinto /etc
	doins ${FILESDIR}/logrotate.conf

	keepdir /etc/logrotate.d
}

pkg_postinst() {
	einfo "If you wish to have logrotate e-mail you updates, please"
	einfo "emerge net-mail/mailx and configure logrotate in"
	einfo "/etc/logrotate.conf appropriately"
	einfo ""
	einfo "Additionally, /etc/logrotate.conf may need to be modified"
	einfo "for your particular needs.  See man logrotate for details."
}

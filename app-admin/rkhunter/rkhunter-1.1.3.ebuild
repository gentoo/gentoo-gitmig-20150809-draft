# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rkhunter/rkhunter-1.1.3.ebuild,v 1.2 2004/07/24 13:00:37 solar Exp $

DESCRIPTION="Rootkit Hunter scans for known and unknown rootkits, backdoors, and sniffers."
HOMEPAGE="http://www.rootkit.nl/"
SRC_URI="http://downloads.rootkit.nl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc"
IUSE=""
DEPEND="app-arch/tar
	app-arch/gzip
	virtual/mta"
RDEPEND="app-shells/bash
	dev-lang/perl"

src_install() {
	cd ${WORKDIR}/${PN}/files
	dodir /usr/lib/rkhunter
	dodir /usr/lib/rkhunter/db
	insinto /usr/lib/rkhunter/db
	doins *.dat
	dodir /usr/lib/rkhunter/scripts
	exeinto /usr/lib/rkhunter/scripts
	doexe *.pl
	insinto /etc
	doins rkhunter.conf
	dosed "s:#DBDIR=/usr/local/rkhunter/db:DBDIR=/usr/lib/rkhunter/db\nINSTALLDIR=/usr:g" /etc/rkhunter.conf
	exeinto /usr/bin
	doexe rkhunter
	dodoc CHANGELOG LICENSE README WISHLIST

	exeinto /etc/cron.daily
	newexe ${FILESDIR}/rkhunter.cron rkhunter
}

pkg_postinst() {
	echo
	einfo "A cron script has been installed to /etc/cron.daily/rkhunter."
	einfo "To enable it, edit /etc/cron.daily/rkhunter and follow the"
	einfo "directions."
	echo
}

pkg_prerm() {
	rm -rf /usr/lib/rkhunter/tmp
}

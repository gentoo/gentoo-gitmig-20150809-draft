# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rkhunter/rkhunter-1.1.8.ebuild,v 1.6 2004/11/07 02:46:48 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="Rootkit Hunter scans for known and unknown rootkits, backdoors, and sniffers."
HOMEPAGE="http://www.rootkit.org/"
SRC_URI="http://downloads.rootkit.nl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha ~amd64 sparc"
IUSE=""
S=${WORKDIR}/${PN}
DEPEND="app-arch/tar
	app-arch/gzip
	virtual/mta"
RDEPEND="app-shells/bash
	dev-lang/perl"

src_install() {
	cd ${S}/files
	dodir /usr/lib/rkhunter
	dodir /usr/lib/rkhunter/db
	insinto /usr/lib/rkhunter/db
	doins *.dat
	dodir /usr/lib/rkhunter/scripts
	exeinto /usr/lib/rkhunter/scripts
	doexe *.pl check_update.sh
	insinto /etc
	doins rkhunter.conf
	dosed "s:#DBDIR=/usr/local/rkhunter/db:DBDIR=/usr/lib/rkhunter/db\nINSTALLDIR=/usr:g" /etc/rkhunter.conf
	exeinto /usr/bin
	doexe rkhunter
	dodoc CHANGELOG LICENSE README WISHLIST

	exeinto /etc/cron.daily
	newexe ${FILESDIR}/rkhunter.cron rkhunter

	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	echo
	einfo "A cron script has been installed to /etc/cron.daily/rkhunter."
	einfo "To enable it, edit /etc/cron.daily/rkhunter and follow the"
	einfo "directions."
	bash-completion_pkg_postinst
}

pkg_prerm() {
	rm -rf /usr/lib/rkhunter/tmp
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rkhunter/rkhunter-1.2.8.ebuild,v 1.1 2006/02/22 02:35:06 ka0ttic Exp $

inherit eutils bash-completion

DESCRIPTION="Rootkit Hunter scans for known and unknown rootkits, backdoors, and sniffers."
HOMEPAGE="http://www.rootkit.nl/"
SRC_URI="http://downloads.rootkit.nl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/mta
	app-shells/bash
	dev-lang/perl
	sys-process/lsof"

S="${WORKDIR}/${PN}/files"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.3-specify-logfile.patch
	epatch ${FILESDIR}/${PN}-1.2.1-create-tmpdir.diff
}

src_install() {
	insinto /usr/lib/rkhunter/db
	doins *.dat || die "failed to install dat files"

	exeinto /usr/lib/rkhunter/scripts
	doexe *.pl check_update.sh || die "failed to install scripts"

	dobin rkhunter || die "failed to install rkhunter script"

	insinto /etc
	doins rkhunter.conf || die "failed to install rkhunter.conf"
	dosed 's:^#\(DBDIR=.*\)local\(.*\)$:\1lib\2\nINSTALLDIR=/usr:' \
		/etc/rkhunter.conf || die "sed rkhunter.conf failed"

	doman development/rkhunter.8 || die "doman failed"
	dodoc CHANGELOG LICENSE README WISHLIST || die "dodoc failed"

	exeinto /etc/cron.daily
	newexe ${FILESDIR}/rkhunter.cron rkhunter || \
		die "failed to install cron script"
	dobashcompletion ${FILESDIR}/${PN}.bash-completion
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

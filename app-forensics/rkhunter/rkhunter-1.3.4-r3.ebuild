# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rkhunter/rkhunter-1.3.4-r3.ebuild,v 1.8 2010/07/09 02:26:38 jer Exp $

EAPI=2

inherit eutils bash-completion

DESCRIPTION="Rootkit Hunter scans for known and unknown rootkits, backdoors, and sniffers."
HOMEPAGE="http://rkhunter.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~mips ppc sparc x86"
IUSE=""

RDEPEND="
	app-shells/bash
	dev-lang/perl
	sys-process/lsof
	virtual/cron
"

S="${WORKDIR}/${P}/files"

src_prepare() {
	epatch "${FILESDIR}/${PN}.conf.patch"
	epatch "${FILESDIR}/${PN}-ppc64.patch"
}

src_install() {
	# rkhunter requires to be root
	dosbin ${PN}

	# rkhunter doesn't create it by itself
	dodir /var/lib/${PN}/tmp

	insinto /etc
	doins ${PN}.conf || die "failed to install ${PN}.conf"

	exeinto /usr/lib/${PN}/scripts
	doexe *.pl || die "failed to install scripts"

	insinto /var/lib/${PN}/db
	doins *.dat || die "failed to install dat files"

	insinto /var/lib/${PN}/db/i18n
	doins i18n/*

	doman ${PN}.8 || die "doman failed"
	dodoc ACKNOWLEDGMENTS CHANGELOG FAQ README WISHLIST || die "dodoc failed"

	exeinto /etc/cron.daily
	newexe "${FILESDIR}/${PN}-1.3.cron" ${PN} || \
		die "failed to install cron script"

	dobashcompletion "${FILESDIR}/${PN}.bash-completion"
}

pkg_postinst() {
	elog "A cron script has been installed to /etc/cron.daily/rkhunter."
	elog "To enable it, edit /etc/cron.daily/rkhunter and follow the"
	elog "directions."
	elog "If you want ${PN} to send mail, you will need to install"
	elog "virtual/mailx as well."
	bash-completion_pkg_postinst
}

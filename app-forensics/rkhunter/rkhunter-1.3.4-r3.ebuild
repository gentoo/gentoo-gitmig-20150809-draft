# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rkhunter/rkhunter-1.3.4-r3.ebuild,v 1.3 2009/12/20 23:50:44 cla Exp $

EAPI=2

inherit eutils bash-completion

DESCRIPTION="Rootkit Hunter scans for known and unknown rootkits, backdoors, and sniffers."
HOMEPAGE="http://rkhunter.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~mips ~ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/mta
	app-shells/bash
	dev-lang/perl
	sys-process/lsof"

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
	einfo
	einfo "A cron script has been installed to /etc/cron.daily/rkhunter."
	einfo "To enable it, edit /etc/cron.daily/rkhunter and follow the"
	einfo "directions."
	einfo
	bash-completion_pkg_postinst
}

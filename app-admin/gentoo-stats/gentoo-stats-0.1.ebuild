# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-stats/gentoo-stats-0.1.ebuild,v 1.12 2003/02/13 05:18:43 vapier Exp $

DESCRIPTION="Gentoo usage statistics client daemon"
HOMEPAGE="http://stats.gentoo.org"
SRC_URI="ftp://stats.gentoo.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc  -alpha"

RDEPEND=">=sys-devel/perl-5.6.1
	dev-perl/libwww-perl"
DEPEND=""

src_install() {
	into /usr
	dosbin gentoo-stats
}

pkg_postinst() {
	einfo 'You must run "gentoo-stats --new" to obtain a system ID.'
	einfo "After that, create a new cronjob that looks like this:"
	einfo ""
	einfo "\t0 0 * * 0,4 /usr/sbin/gentoo-stats --update <your system ID>"
	einfo ""
	einfo 'You can edit your cron jobs with "crontab -e" or'
	einfo '"fcrontab -e" (depending on the cron daemon you use).'
}

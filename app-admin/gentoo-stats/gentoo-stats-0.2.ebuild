# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-stats/gentoo-stats-0.2.ebuild,v 1.3 2002/10/15 04:27:47 blizzy Exp $

DESCRIPTION="Gentoo Linux usage statistics client daemon"
HOMEPAGE="http://stats.gentoo.org"
SRC_URI="http://stats.gentoo.org/client/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

# devs: please do not change this, it wouldn't make much sense right now
KEYWORDS="x86 -ppc -sparc -sparc64 -alpha"

RDEPEND=">=sys-devel/perl-5.6.1
	dev-perl/libwww-perl
	sys-apps/textutils
	sys-apps/pciutils"
DEPEND=""

S=${WORKDIR}/${P}

src_install () {
	into /usr
	dosbin gentoo-stats
	insinto /etc/gentoo-stats
	doins gentoo-stats.conf
}

pkg_postinst() {
	ewarn "Please edit /etc/gentoo-stats/gentoo-stats.conf to suit"
	ewarn "your needs."

	echo

	einfo 'To obtain a new system ID, run "gentoo-stats --new".'
	einfo
	einfo "After that, install a new cron job:"
	einfo ""
	einfo "\t0 0 * * 0,4 /usr/sbin/gentoo-stats --update >/dev/null"
	einfo ""
	einfo '(You can edit your cron jobs with "crontab -e" or'
	einfo '"fcrontab -e", depending on the cron daemon you use.)'

	echo

	ewarn "If you're updating from <gentoo-stats-0.2, please remove"
	ewarn "your system ID from the cron job and enter it in"
	ewarn "/etc/gentoo-stats/gentoo-stats.conf instead."
}

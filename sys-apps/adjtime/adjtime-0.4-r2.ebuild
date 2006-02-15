# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/adjtime/adjtime-0.4-r2.ebuild,v 1.1 2006/02/15 03:31:48 nerdboy Exp $

DESCRIPTION="A script to adjust the clock tick on the Kurobox and LinkStation hardware clock."
HOMEPAGE="http://groups.yahoo.com/group/LinkStation_General/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

RDEPEND="dev-lang/perl
	=net-misc/ntp-4.2.0*"

src_install() {
	dodir /usr/sbin
	dosbin ${FILESDIR}/adjtime.pl || die
}

pkg_postinst() {
	ewarn "There have been issues with running adjtime as an init script"
	ewarn "(the shell environment for perl is dorked up).  The suggested"
	ewarn "method is to use ntp-date rather than ntpd at startup, and"
	ewarn "add the following two lines to local.start instead:"
	einfo
	einfo "/usr/bin/perl /usr/sbin/adjtime.pl -v -s ntp_host -i 60"
	einfo
	einfo "/etc/init.d/ntpd start"
	einfo
	einfo "replacing ntp_host with your preferred ntp server.  Remember,"
	einfo "since adjtime uses ntp-date, ntpd must be stopped (or not yet"
	einfo "started) prior to running the adjtime script."
}


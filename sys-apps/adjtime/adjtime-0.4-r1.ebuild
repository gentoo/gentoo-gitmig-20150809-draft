# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/adjtime/adjtime-0.4-r1.ebuild,v 1.1 2006/01/22 22:36:50 nerdboy Exp $

inherit eutils

DESCRIPTION="A script to adjust the clock tick on the Kurobox and LinkStation hardware clock."
HOMEPAGE="http://groups.yahoo.com/group/LinkStation_General/"
#SRC_URI="http://dev.gentoo.org~/nerdboy/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

RDEPEND="dev-lang/perl
	>=net-misc/ntp-4.2*"

src_install() {
	dodir /usr/sbin
	dosbin ${FILESDIR}/adjtime.pl || die
	dodir /etc/init.d
	newinitd "${FILESDIR}/adjtime.init" adjtime || die
	dodir /etc/conf.d
	newconfd "${FILESDIR}/adjtime.conf" adjtime || die
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] \
	&& [ ! -f /etc/runlevels/default/adjtime ] ; then
		rc-update add adjtime default
	fi
}

pkg_postrm() {
	if [ "${ROOT}" = "/" ] \
	&& [ ! -f /usr/sbin/adjtime ] ; then
		rc-update del adjtime default
	fi
}

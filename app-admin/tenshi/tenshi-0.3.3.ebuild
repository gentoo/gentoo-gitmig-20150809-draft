# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tenshi/tenshi-0.3.3.ebuild,v 1.5 2007/01/24 15:03:16 genone Exp $

inherit eutils

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://tenshi.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://www.gentoo.org/~lcars/tenshi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~ppc ~sparc"
IUSE=""

RDEPEND="dev-lang/perl
	sys-apps/coreutils"

pkg_setup() {
	enewgroup tenshi
	enewuser tenshi -1 -1 /var/lib/tenshi tenshi
}

src_install() {
	sed -i -e "s:-o tenshi::" Makefile
	emake DESTDIR=${D} install
	fowners tenshi:root /etc/tenshi/tenshi.conf
	fowners tenshi:root /var/lib/tenshi
	doman tenshi.8
	exeinto /etc/init.d
	newexe tenshi.gentoo-init tenshi
	keepdir /var/lib/tenshi
}

pkg_postinst() {
	elog
	elog "This app was formerly known as wasabi. The name was changed"
	elog "due to trademark issues. If you are upgrading from an old"
	elog "wasabi version please consider removing the 'wasabi' user"
	elog "which was created by the old ebuilds."
	elog
	elog "Please also be aware that if upgrading from versions <=0.2"
	elog "the configuration syntax for time intervals has changed to"
	elog "crontab style entries, old configurations won't work. Please"
	elog "check the manpage for full details."
	elog
}

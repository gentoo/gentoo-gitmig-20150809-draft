# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tenshi/tenshi-0.3.3.ebuild,v 1.1 2005/03/18 11:03:52 tigger Exp $

inherit eutils

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://tenshi.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://www.gentoo.org/~lcars/tenshi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND="dev-lang/perl
	sys-apps/coreutils"

pkg_setup() {
	enewgroup tenshi
	enewuser tenshi -1 /bin/false /var/lib/tenshi tenshi
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
	einfo
	einfo "This app was formerly known as wasabi. The name was changed"
	einfo "due to trademark issues. If you are upgrading from an old"
	einfo "wasabi version please consider removing the 'wasabi' user"
	einfo "which was created by the old ebuilds."
	einfo
	einfo "Please also be aware that if upgrading from versions <=0.2"
	einfo "the configuration syntax for time intervals has changed to"
	einfo "crontab style entries, old configurations won't work. Please"
	einfo "check the manpage for full details."
	einfo
}

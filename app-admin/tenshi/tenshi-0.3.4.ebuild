# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tenshi/tenshi-0.3.4.ebuild,v 1.3 2005/08/23 12:47:51 tigger Exp $

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

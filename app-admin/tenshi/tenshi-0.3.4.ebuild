# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tenshi/tenshi-0.3.4.ebuild,v 1.5 2007/04/28 16:55:17 tove Exp $

inherit eutils

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://tenshi.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://www.gentoo.org/~lcars/tenshi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-lang/perl
	sys-apps/coreutils"

pkg_setup() {
	enewgroup tenshi
	enewuser tenshi -1 -1 /var/lib/tenshi tenshi
}

src_install() {
	sed -i -e "s:-o tenshi::" Makefile
	emake DESTDIR="${D}" install
	fowners tenshi:root /etc/tenshi/tenshi.conf
	fowners tenshi:root /var/lib/tenshi
	doman tenshi.8
	newinitd tenshi.gentoo-init tenshi
	keepdir /var/lib/tenshi
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tenshi/tenshi-0.9.1-r1.ebuild,v 1.2 2008/03/21 11:53:05 maekke Exp $

inherit eutils

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://dev.inversepath.com/trac/tenshi"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.inversepath.com/tenshi/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-lang/perl
	sys-apps/coreutils"

pkg_setup() {
	enewgroup tenshi
	enewuser tenshi -1 -1 /var/lib/tenshi tenshi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix for bug #212213
	epatch "${FILESDIR}/${P}-fix-tail_pids-array-length.patch"
}

src_install() {
	emake DESTDIR="${D}" install
	fowners tenshi:root /etc/tenshi/tenshi.conf
	dodir /var/lib/tenshi
	fowners tenshi:root /var/lib/tenshi
	doman tenshi.8
	newinitd tenshi.gentoo-init tenshi
	keepdir /var/lib/tenshi
}

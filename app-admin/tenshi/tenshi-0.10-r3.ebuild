# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tenshi/tenshi-0.10-r3.ebuild,v 1.1 2008/12/02 20:46:54 hncaldwell Exp $

inherit eutils

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://dev.inversepath.com/trac/tenshi"
SRC_URI="http://dev.inversepath.com/tenshi/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/IO-BufferedSelect
	sys-apps/coreutils"

pkg_setup() {
	enewgroup tenshi
	enewuser tenshi -1 -1 /var/lib/tenshi tenshi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-create-mandir.patch"
	# Fix for bug #218042
	epatch "${FILESDIR}/${PN}-openrc-init.patch"
	# Fix for bug #217000
	epatch "${FILESDIR}/${PN}-remove-timezone-cache.patch"

	# Fixes for bug #243082
	epatch "${FILESDIR}/${PN}-0.10-solo-queue-escalation.patch"
	epatch "${FILESDIR}/${PN}-0.10-warn-logfile.patch"
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

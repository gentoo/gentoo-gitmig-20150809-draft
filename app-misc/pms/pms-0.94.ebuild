# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pms/pms-0.94.ebuild,v 1.6 2004/06/19 03:39:05 mr_bones_ Exp $

DESCRIPTION="Password Management System"
HOMEPAGE="http://passwordms.sourceforge.net/"
SRC_URI="mirror://sourceforge/passwordms/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses
	dev-libs/cdk"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch pms/ui.c "${FILESDIR}/ui.diff"
}

src_install() {
	dobin bin/{pms,pms_export,pms_import,pms_passwd} || die "dobin failed"
	dodoc AUTHORS BUGS ChangeLog NOTES README TODO CONFIGURE.problems
}

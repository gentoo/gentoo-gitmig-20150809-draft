# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pms/pms-0.94.ebuild,v 1.5 2004/03/14 10:52:44 mr_bones_ Exp $

IUSE="ncurses"
DESCRIPTION="Password Management System"
SRC_URI="mirror://sourceforge/passwordms/${P}.tar.gz"
HOMEPAGE="http://passwordms.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

SLOT="0"

DEPEND="sys-libs/ncurses
	dev-libs/cdk"

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	patch pms/ui.c ${FILESDIR}/ui.diff
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed."
}

src_install() {

	install -d ${D}/usr/bin && \
	install ${S}/bin/pms ${D}/usr/bin && \
	install ${S}/bin/pms_export ${D}/usr/bin && \
	install ${S}/bin/pms_import ${D}/usr/bin && \
	install ${S}/bin/pms_passwd ${D}/usr/bin || die

	dodoc AUTHORS BUGS COPYING ChangeLog \
	NOTES README TODO CONFIGURE.problems
}





# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mysql/pam_mysql-0.7_rc1.ebuild,v 1.4 2006/05/19 18:56:22 dertobi123 Exp $

inherit libtool

DESCRIPTION="pam_mysql is a module for pam to authenticate users with mysql"
HOMEPAGE="http://pam-mysql.sourceforge.net/"

SRC_URI="mirror://sourceforge/pam-mysql/${P/_rc/RC}.tar.gz"
DEPEND=">=sys-libs/pam-0.72 >=dev-db/mysql-3.23.38"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86"
IUSE=""
S="${WORKDIR}/${P/_rc/RC}"

src_unpack() {
	unpack ${A}

	cd ${S}
	elibtoolize
}

src_compile() {
	econf
	emake
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc CREDITS ChangeLog NEWS README
}

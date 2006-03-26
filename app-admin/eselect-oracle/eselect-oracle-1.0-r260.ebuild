# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-oracle/eselect-oracle-1.0-r260.ebuild,v 1.2 2006/03/26 15:53:35 dertobi123 Exp $

DESCRIPTION="Utility to change the Oracle SQL*Plus Instantclient being used"
HOMEPAGE="http://www.gentoo.org/"

SRC_URI="http://www.scherbaum.info/~tobias/eselect/${P}-r260.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0
	dev-db/oracle-instantclient-sqlplus"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/eselect/modules
	doins oracle.eselect
}

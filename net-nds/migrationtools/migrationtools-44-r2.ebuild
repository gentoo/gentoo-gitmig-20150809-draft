# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/migrationtools/migrationtools-44-r2.ebuild,v 1.1 2005/01/07 12:24:23 robbat2 Exp $

inherit eutils

PN0=MigrationTools
S=${WORKDIR}/${PN0}-${PV}
DESCRIPTION="PADL migration tools (scripts) for openldap"
SRC_URI="ftp://ftp.padl.com/pub/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://www.padl.com/OSS/MigrationTools.html"

SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
LICENSE="as-is"

DEPEND=""

RDEPEND="net-nds/openldap"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/skip-account-objectclass.patch
}

src_install() {
	dodoc README
	insinto /usr/share/migrationtools
	doins migrate_*
}

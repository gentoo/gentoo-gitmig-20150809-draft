# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/migrationtools/migrationtools-44-r1.ebuild,v 1.7 2004/03/30 07:56:26 aliz Exp $

PN0=MigrationTools
S=${WORKDIR}/${PN0}-${PV}
DESCRIPTION="PADL migration tools (scripts) for openldap"
SRC_URI="ftp://ftp.padl.com/pub/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://www.padl.com/OSS/MigrationTools.html"

SLOT="0"
KEYWORDS="x86 sparc ~amd64"
LICENSE="as-is"

DEPEND=""

RDEPEND="net-nds/openldap"

src_install() {
	dodoc README
	dodir /usr/share/migrationtools
	cp -a ${S}/migrate_* ${D}/usr/share/migrationtools
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/migrationtools/migrationtools-46.ebuild,v 1.1 2004/11/01 01:44:11 robbat2 Exp $

inherit eutils

PN0=MigrationTools
S=${WORKDIR}/${PN0}-${PV}
DESCRIPTION="PADL migration tools (scripts) for openldap"
SRC_URI="http://www.padl.com/download/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://www.padl.com/OSS/MigrationTools.html"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~hppa ~ppc"
LICENSE="as-is"
IUSE=""

DEPEND=""
RDEPEND="net-nds/openldap
		 dev-lang/perl"

src_compile() {
	einfo "nothing to compile; scripts package"
}

src_install() {
	dodoc README

	diropts -m0750
	dodir /usr/share/migrationtools
	exeinto /usr/share/migrationtools
	exeopts -m0750
	for x in ${S}/migrate_*; do
		[ -f ${x} ] && doexe ${x}
	done
						
	diropts -m0750
	dodir /usr/share/migrationtools/ads
	exeinto /usr/share/migrationtools/ads
	exeopts -m0750
	for x in ${S}/ads/migrate_*; do
		[ -f ${x} ] && doexe ${x}
	done
}

pkg_postinst() {
	draw_line "                                                           "
	einfo "The scripts are installed at /usr/share/migrationtools."
	einfo ""
	einfo "Please edit /usr/share/migrationtools/migrate_common.ph"
	einfo "and/or /usr/share/migrationtools/ads/migrate_common.ph"
	einfo "to start."
	draw_line "                                                           "
}


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-services/ptlink-services-2.25.1.ebuild,v 1.2 2004/11/21 23:22:10 swegener Exp $

inherit fixheadtails eutils

MY_P="PTlink.Services${PV}"

DESCRIPTION="PTlink Services"
HOMEPAGE="http://www.ptlink.net/"
SRC_URI="ftp://ftp.sunsite.dk/projects/ptlink/services2/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mysql"

DEPEND="mysql? ( dev-db/mysql )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	ht_fix_file configure

	find ${S} -type d -name CVS -exec rm -rf {} \; 2>/dev/null
}

src_compile() {
	econf $(use_with mysql) || die "econf failed"

	# Now we're going to override the paths setup by configure
	echo "#define BINPATH \"/usr/bin\"" > include/path.h
	echo "#define ETCPATH \"/etc/ptlink-services\"" >> include/path.h
	echo "#define DATAPATH \"/var/lib/ptlink-services\"" >> include/path.h

	emake CFLAGS="${CFLAGS}" || die "emake failed"
	emake -C src/lang CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newbin src/services ptlink-services || die "newbin failed"

	keepdir /var/{lib,log}/ptlink-services
	dosym /var/log/ptlink-services /var/lib/ptlink-services/logs

	insinto /usr/share/ptlink-services/languages
	for file in src/lang/*.l ; do
		doins src/lang/$(basename ${file} .l) || die "doins failed"
		doins src/lang/$(basename ${file} .l).auth || die "doins failed"
		doins src/lang/$(basename ${file} .l).setemail || die "doins failed"
	done
	dosym /usr/share/ptlink-services/languages /var/lib/ptlink-services

	insinto /etc/ptlink-services
	newins data/example.conf services.conf || die "newins failed"
	doins data/create_tables.sql data/domain.def || die "doins failed"

	dohtml html_manual/* || die "dohtml failed"
	dodoc CHANGES FAQ FEATURES README || die "dodoc failed"

	newinitd ${FILESDIR}/ptlink-services.init.d ptlink-services
	newconfd ${FILESDIR}/ptlink-services.conf.d ptlink-services
}

pkg_postinst() {
	enewuser ptlink-services
	chown ptlink-services ${ROOT}/var/{log,lib}/ptlink-services
}

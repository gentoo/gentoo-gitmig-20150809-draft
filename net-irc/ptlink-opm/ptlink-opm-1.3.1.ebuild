# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-opm/ptlink-opm-1.3.1.ebuild,v 1.1 2004/11/14 15:41:35 swegener Exp $

inherit eutils

MY_P="PTlink.OPM${PV}"

DESCRIPTION="PTlink Open Proxy Monitor"
HOMEPAGE="http://www.ptlink.net/"
SRC_URI="ftp://ftp.sunsite.dk/projects/ptlink/ptopm/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's:ptopm\.dconf:/etc/ptlink-opm/ptopm.dconf:' \
		-e 's:ptopm\.log:log/ptopm.log:' \
		${S}/src/ptopm.c
}

src_compile() {
	econf || die "econf failed"

	# Now we're going to override the paths setup by configure
	echo "#define BINPATH \"/usr/bin\"" > include/path.h
	echo "#define VARPATH \"/var/lib/ptlink-opm\"" >> include/path.h
	echo "#define ETCPATH \"/etc\"" >> include/path.h

	emake || die "emake failed"
}

src_install() {
	newbin src/ptopm ptlink-opm || die "newbin failed"

	keepdir /var/{lib,log}/ptlink-opm || die "keepdir failed"
	dosym /var/log/ptlink-opm /var/lib/ptlink-opm/log || die "dosym failed"

	insinto /etc/ptlink-opm
	newins samples/ptopm.dconf.sample ptopm.dconf || die "newins failed"

	dodoc CHANGES README || die "dodoc failed"

	newinitd ${FILESDIR}/ptlink-opm.init.d ptlink-opm || die "newinitd failed"
	newconfd ${FILESDIR}/ptlink-opm.conf.d ptlink-opm || die "newconfd failed"
}

pkg_postinst() {
	enewuser ptlink-opm
	chown ptlink-opm ${ROOT}/var/{log,lib}/ptlink-opm
}

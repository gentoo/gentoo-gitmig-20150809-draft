# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/pmacct-0.7.0.ebuild,v 1.2 2005/01/09 07:44:27 dragonheart Exp $

DESCRIPTION="A network tool to gather ip traffic informations"
HOMEPAGE="http://www.ba.cnr.it/~paolo/pmacct/"
SRC_URI="http://www.ba.cnr.it/~paolo/pmacct/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="mysql postgres"

RDEPEND="net-libs/libpcap
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

src_compile() {
	econf 	`use_enable mysql mysql` \
		`use_enable postgres pgsql` \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc README EXAMPLE KNOWN-BUGS CONFIG-KEYS FAQS ChangeLog SIGNALS TODO TOOLS || die "dodoc failed"

	for dirname in examples sql pcap; do
		docinto ${dirname}
		dodoc ${dirname}/* || die "dodoc failed"
	done

	exeinto /etc/init.d
	newexe ${FILESDIR}/pmacctd-init.d pmacctd || die "newexe failed"

	insinto /etc/conf.d
	newins ${FILESDIR}/pmacctd-conf.d pmacctd || die "newins failed"

	insinto /etc
	newins ${S}/examples/pmacctd-imt.conf.example pmacctd.conf.example || "newins failed"
}


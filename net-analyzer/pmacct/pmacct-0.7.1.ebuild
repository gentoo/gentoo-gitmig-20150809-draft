# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/pmacct-0.7.1.ebuild,v 1.1 2004/07/16 09:25:01 eldad Exp $

DESCRIPTION="A network tool to gather ip traffic informations"
HOMEPAGE="http://www.ba.cnr.it/~paolo/pmacct/"
SRC_URI="http://www.ba.cnr.it/~paolo/pmacct/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="mysql postgres mmap"

RDEPEND="net-libs/libpcap
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

src_compile() {
	econf 	`use_enable mysql` \
		`use_enable postgres pgsql` \
		`use_enable mmap` \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc README EXAMPLES KNOWN-BUGS CONFIG-KEYS FAQS ChangeLog docs/SIGNALS docs/PLUGINS docs/INTERNALS TODO TOOLS || die "dodoc failed"

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


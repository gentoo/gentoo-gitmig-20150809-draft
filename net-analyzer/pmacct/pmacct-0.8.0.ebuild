# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/pmacct-0.8.0.ebuild,v 1.1 2005/01/12 19:24:18 dragonheart Exp $

DESCRIPTION="A network tool to gather ip traffic informations"
HOMEPAGE="http://www.ba.cnr.it/~paolo/pmacct/"
SRC_URI="http://www.ba.cnr.it/~paolo/pmacct/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="ipv6 mmap mysql postgres"

RDEPEND=">=net-libs/libpcap-0.6
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

src_compile() {
	sed -i -e 's/CFLAGS="-O2"/CFLAGS=""/g' configure
	econf 	`use_enable mysql` \
		`use_enable postgres pgsql` \
		`use_enable mmap` \
		`use_enable ipv6` \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc README EXAMPLES KNOWN-BUGS CONFIG-KEYS FAQS ChangeLog docs/SIGNALS docs/PLUGINS docs/INTERNALS TODO TOOLS || die "dodoc failed"

	for dirname in examples sql; do
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


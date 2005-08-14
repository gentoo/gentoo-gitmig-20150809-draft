# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/pmacct-0.8.7.ebuild,v 1.3 2005/08/14 10:15:20 hansmi Exp $

MY_P="${P%_*}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A network tool to gather ip traffic informations"
HOMEPAGE="http://www.ba.cnr.it/~paolo/pmacct/"
SRC_URI="http://www.ba.cnr.it/~paolo/pmacct/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="ipv6 mmap mysql postgres"

RDEPEND="virtual/libpcap
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s|\(CFLAGS=\).*$|\1\"${CFLAGS}\"|g" configure || die "sed failed"
}

src_compile() {
	econf \
		$(use_enable mysql) \
		$(use_enable postgres pgsql) \
		$(use_enable mmap) \
		$(use_enable ipv6) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README EXAMPLES KNOWN-BUGS CONFIG-KEYS FAQS ChangeLog docs/SIGNALS \
		docs/PLUGINS docs/INTERNALS TODO TOOLS || die "dodoc failed"

	for dirname in examples sql; do
		docinto ${dirname}
		dodoc ${dirname}/* || die "dodoc ${dirname} failed"
	done

	newinitd ${FILESDIR}/pmacctd-init.d pmacctd || die "newinitd failed"
	newconfd ${FILESDIR}/pmacctd-conf.d pmacctd || die "newconfd failed"

	insinto /etc
	newins ${S}/examples/pmacctd-imt.conf.example pmacctd.conf.example || \
		die "newins failed"
}

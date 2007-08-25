# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/pmacct-0.11.4.ebuild,v 1.1 2007/08/25 16:35:13 cedk Exp $

DESCRIPTION="A network tool to gather ip traffic informations"
HOMEPAGE="http://www.pmacct.net/"
SRC_URI="http://www.pmacct.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="64bit debug ipv6 mmap mysql postgres sqlite3"

RDEPEND="net-libs/libpcap
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	sqlite3? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s|\(CFLAGS=\).*$|\1\"${CFLAGS}\"|g" configure || die "sed failed"
}

src_compile() {
	econf \
		$(use_enable mysql) \
		$(use_enable postgres pgsql) \
		$(use_enable mmap) \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable 64bit) \
		$(use_enable sqlite3) \
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

	newinitd "${FILESDIR}"/pmacctd-init.d pmacctd || die "newinitd failed"
	newconfd "${FILESDIR}"/pmacctd-conf.d pmacctd || die "newconfd failed"

	insinto /etc
	newins "${S}"/examples/pmacctd-imt.conf.example pmacctd.conf.example || \
		die "newins failed"
}

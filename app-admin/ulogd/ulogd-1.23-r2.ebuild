# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-1.23-r2.ebuild,v 1.5 2009/01/25 00:55:58 darkside Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="http://ftp.netfilter.org/pub/ulogd/${P}.tar.bz2
	mirror://gentoo/${PN}-glsa-200701.patch.bz2"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE="sqlite3 mysql postgres ip-as-string pcap"

DEPEND="net-firewall/iptables
	sqlite3? ( =dev-db/sqlite-3* )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )"
RDEPEND="${DEPEND}
	pcap? ( net-libs/libpcap )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-configure.in.patch"
	EPATCH_OPTS="-F3" \
		epatch "${WORKDIR}/${PN}-glsa-200701.patch"

	eautoreconf
}

src_compile() {
	# enables logfiles over 2G (#74924)
	append-lfs-flags

	myconf=""
	if use ip-as-string; then
	    use sqlite3  && myconf="${myconf} --with-sqlite3-log-ip-as-string"
		use mysql    && myconf="${myconf} --with-mysql-log-ip-as-string"
		use postgres && myconf="${myconf} --with-pgsql-log-ip-as-string"
	fi

	if [[ -z "${myconf}" ]]; then
	    ewarn
		ewarn "No database support enabled, ip-as-string flag ignored."
		epause
	fi

	myconf="${myconf} `use_with sqlite3`"
	myconf="${myconf} `use_with mysql`"
	myconf="${myconf} `use_with postgres pgsql`"

	econf ${myconf}

	# not parallel make safe: bug #128976
	emake -j1 || die "make failed"
}

src_install() {
	# the Makefile seems to be "broken" -
	# it relies on the existance of /usr, /etc ..
	dodir /usr/sbin

	make DESTDIR="${D}" install || die "install failed"

	newinitd "${FILESDIR}"/ulogd-0.98 ulogd

	dodoc README AUTHORS Changes
	cd doc/
	dodoc ulogd.txt ulogd.a4.ps

	if use mysql; then
		dodoc mysql.table mysql.table.ipaddr-as-string
	fi

	if use postgres; then
		dodoc pgsql.table
	fi

	dohtml ulogd.html
}

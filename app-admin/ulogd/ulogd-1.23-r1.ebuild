# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-1.23-r1.ebuild,v 1.8 2010/10/07 15:45:42 mr_bones_ Exp $

inherit eutils flag-o-matic linux-info

DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="http://ftp.netfilter.org/pub/ulogd/${P}.tar.bz2
	mirror://gentoo/${PN}-glsa-200701.patch.bz2"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc -sparc x86"
IUSE="mysql postgres"

DEPEND="net-firewall/iptables
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )"

pkg_setup() {
	# can't depend on supported kernel versions because dependencies
	# on virtuals are not versioned
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
	kernel_is ge 2 6 31 && die "kernel version is too new -- try a newer ulogd"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
	EPATCH_OPTS="-F3" \
		epatch "${WORKDIR}/${PN}-glsa-200701.patch"
}

src_compile() {
	# enables logfiles over 2G (#74924)
	append-lfs-flags

	econf \
		`use_with mysql` \
		`use_with postgres pgsql` \
		|| die "configure failed"

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

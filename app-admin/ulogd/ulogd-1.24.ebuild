# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-1.24.ebuild,v 1.7 2008/05/21 15:44:43 dev-zero Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="A userspace logging daemon for netfilter/iptables related logging"
HOMEPAGE="http://netfilter.org/projects/ulogd/index.html"
SRC_URI="http://ftp.netfilter.org/pub/ulogd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc -sparc ~x86"
IUSE="mysql postgres"

DEPEND="net-firewall/iptables
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"

src_compile() {
	# enables logfiles over 2G (#74924)
	append-lfs-flags

	epatch "${FILESDIR}/configure-fixes.patch"
	ewarn "Regenerating build system (this may take a bit)..."
	eautoconf || die "Autoreconf failed"
	econf \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die "configure failed"

	# Configure uses incorrect syntax for ld
	use mysql && sed -i -e "s:-Wl,::g" Rules.make

#	EPATCH_OPTS="-F3" \
#		epatch "${FILESDIR}/glsa-200701.patch"

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

	use mysql && dodoc mysql.table mysql.table.ipaddr-as-string
	use postgres && dodoc pgsql.table

	dohtml ulogd.html
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-1.23.ebuild,v 1.1 2006/03/08 19:34:02 smithj Exp $

inherit flag-o-matic

DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="http://ftp.netfilter.org/pub/ulogd/${P}.tar.bz2"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 -sparc"
IUSE="mysql postgres"

DEPEND="net-firewall/iptables
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

src_compile() {
	# enables logfiles over 2G (#74924)
	append-flags -D_FILE_OFFSET_BITS=64

	econf \
		`use_with mysql` \
		`use_with postgres pgsql` \
		|| die "configure failed"
	make || die "make failed"
}

src_install() {
	# the Makefile seems to be "broken" -
	# it relies on the existance of /usr, /etc ..
	dodir /usr/sbin

	make DESTDIR=${D} install || die "install failed"

	exeinto /etc/init.d/
	newexe ${FILESDIR}/ulogd-0.98 ulogd

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

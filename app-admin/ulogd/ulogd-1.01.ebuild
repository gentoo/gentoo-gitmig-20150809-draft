# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-1.01.ebuild,v 1.13 2005/02/03 06:48:00 eradicator Exp $

DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="http://ftp.netfilter.org/pub/ulogd/${P}.tar.bz2"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc"
IUSE="mysql"

DEPEND="net-firewall/iptables"

src_compile() {
	econf `use_with mysql` || die "configure failed"
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
	dohtml ulogd.html
}

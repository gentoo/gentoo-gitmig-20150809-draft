# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-1.01.ebuild,v 1.1 2003/08/25 13:30:38 aliz Exp $

DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="ftp://ftp.netfilter.org/pub/ulogd/${P}.tar.bz2"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="mysql"
DEPEND="net-firewall/iptables
	>=sys-apps/sed-4"
RDEPEND=${DEPEND}

src_compile() {
	local myconf
	use mysql && myconf="--with-mysql"

	econf ${myconf}
	make all || die "make failed"
}

src_install() {
	# the Makefile seems to be "broken" - 
	# it relies on the existance of /usr, /etc ..
	dodir /usr/sbin /etc/init.d

	make DESTDIR=${D} install || die "install failed"
	
	cp ${FILESDIR}/ulogd-${PV} ${D}/etc/init.d/ulogd

	dodoc README AUTHORS Changes 
	cd doc/
	dodoc ulogd.txt ulogd.a4.ps
	if [ -n "`use mysql`" ]; then
		dodoc mysql.table mysql.table.ipaddr-as-string 
	fi
	dohtml ulogd.html
}

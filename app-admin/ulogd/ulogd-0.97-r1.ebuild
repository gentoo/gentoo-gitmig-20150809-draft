# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-0.97-r1.ebuild,v 1.6 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="ftp://ftp.netfilter.org/pub/ulogd/ulogd-0.97.tar.gz"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

DEPEND="sys-apps/iptables"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	local myconf

	cp ulogd.conf ulogd.conf.orig
	sed -e "s:/usr/local/lib/:/usr/lib/:" ulogd.conf.orig > ulogd.conf
	
	use mysql && myconf="--with-mysql"
	
	econf ${myconf} || die
	make all || die "make failed"
}

src_install() {
	# the Makefile seems to be "broken" - 
	# it relies on the existance of /usr, /etc ..
	mkdir -p ${D}/usr/sbin ${D}/etc/init.d

	make DESTDIR=${D} install || die "install failed"
	
	cp ${FILESDIR}/ulogd ${D}/etc/init.d/ulogd

	dodoc README AUTHORS Changes 
	cd doc/
	dodoc ulogd.txt ulogd.a4.ps mysql.table mysql.table.ipaddr-as-string
	dohtml ulogd.html
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: James A. Stangler <jastangler@yahoo.com>
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulogd/ulogd-0.97.ebuild,v 1.1 2002/05/25 04:50:25 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="iptables daemon for ULOG target for userspace iptables filter logging"
SRC_URI="ftp://ftp.netfilter.org/pub/ulogd/ulogd-0.97.tar.gz"
HOMEPAGE="http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1"

DEPEND="sys-apps/iptables"
RDEPEND=${DEPEND}

LICENSE="GPL-2"

src_compile() {
	use mysql && myconf="--with-mysql=/usr/share/mysql "
	./configure ${myconf} \
		--prefix=/usr \
		--sysconfdir=/etc ||die
	make all || die "make failed"
}

src_install() {
	#the Makefile seems to be "broken" - it relies on the existance of /usr, /etc ..
	mkdir -p ${D}/usr/sbin
	mkdir -p ${D}/etc
	mkdir -p ${D}/etc/init.d
	make DESTDIR=${D} install || die "install failed"
	cp ${FILESDIR}/ulogd ${D}/etc/init.d/ulogd

	dodoc README AUTHORS Changes 
	cd doc/
	dodoc ulogd.txt ulogd.a4.ps
	dohtml ulogd.html
}


# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/nut/nut-0.44.1-r1.ebuild,v 1.5 2002/08/11 14:33:43 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Network-UPS Tools"
SRC_URI="http://www.exploits.org/nut/release/${P}.tar.gz"
HOMEPAGE="http://www.exploits.org/nut/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-libs/libgd-1.8.3
	>=media-libs/libpng-1.2.1"


src_compile() {
	./configure 	\
		--host=${CHOST}	\
		--prefix=/usr	\
		--sysconfdir=/etc/nut \
		--with-user=daemon	\
		--with-group=daemon || die

	make || die

	make cgi || die
}

src_install() {
	dodir /usr/bin
	make 	\
		INSTALLROOT=${D}	\
		STATEPATH=${D}/var/state/ups \
		install || die

	cd clients
	exeinto /home/httpd/cgi-bin/nut
	doexe *.cgi
	into /usr
	dolib upsfetch.o
	insinto /usr/include
	doins upsfetch.h
	cd ..
	rmdir ${D}/usr/misc
	insinto /etc/init.d
	doins ${O}/files/upsd
	dodoc COPYING CREDITS Changes QUICKSTART README
	docinto docs
	dodoc docs/*.txt docs/FAQ docs/Changes.trust
	docinto cables
	dodoc docs/cables/*.txt
}


pkg_config() {

	. ${ROOT}/etc/rc.d/config/functions

	einfo "Generating symlinks..."
	${ROOT}/usr/sbin/rc-update add upsd

}

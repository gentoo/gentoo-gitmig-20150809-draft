# Copyright 2002, Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-0.940.ebuild,v 1.1 2002/11/08 22:43:41 cretin Exp $

IUSE="ssl"

S=${WORKDIR}/usermin-0.940

DESCRIPTION="Usermin, a web-based user administration interface"

SRC_URI="http://twtelecom.dl.sourceforge.net/sourceforge/webadmin/${P}.tar.gz"

HOMEPAGE="http://www.webmin.com/index6.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc sparc64 alpha ppc"

DEPEND="sys-devel/perl
	ssl? ( dev-perl/Net-SSLeay )
	dev-perl/Authen-PAM"

src_install() {
	dodir /usr/libexec/usermin
	dodir /usr/sbin
	mv *.* ${D}/usr/libexec/usermin
	mv * ${D}/usr/libexec/usermin
	exeinto /etc/init.d
	newexe ${FILESDIR}/usermin usermin
	dosym /usr/libexec/usermin /etc/usermin
	dosym /usr/libexec/usermin/usermin-init /usr/sbin/usermin
}

pkg_postinst() {
	einfo "**********************************************************"
	einfo "*   NOTE: To use usermin go into a web browser and type  *"
	einfo "*    http://localhost:20000 and you will be in usermin.  *"
	einfo "**********************************************************"
	echo  ""
	einfo "***********************************************"
	einfo "*  Configure by running /etc/usermin/setup.sh *"
	einfo "*     To start usermin type usermin start     *"
	einfo "*      To stop usermin type usermin stop      *"
	einfo "*   To restart usermin type usermin restart   *"
	einfo "***********************************************"
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-0.940.ebuild,v 1.7 2003/03/11 21:11:44 seemant Exp $

IUSE="ssl"

S=${WORKDIR}/usermin-0.940

DESCRIPTION="Usermin, a web-based user administration interface"

SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"

HOMEPAGE="http://www.webmin.com/index6.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc alpha ppc"

DEPEND="dev-lang/perl
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
	einfo "Configure usermin by running /etc/usermin/setup.sh"
	echo
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

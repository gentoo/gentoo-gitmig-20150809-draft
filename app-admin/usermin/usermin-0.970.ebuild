# Copyright 2002, Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-0.970.ebuild,v 1.5 2002/12/15 01:04:26 seemant Exp $

IUSE="ssl"

DESCRIPTION="Usermin, a web-based user administration interface"
SRC_URI="http://twtelecom.dl.sourceforge.net/sourceforge/webadmin/${P}.tar.gz"
HOMEPAGE="http://www.webmin.com/index6.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc alpha ppc"

DEPEND="sys-devel/perl
	sys-apps/lsof
	ssl? ( dev-perl/Net-SSLeay )
	dev-perl/Authen-PAM"

src_install() {
	dodir /usr/libexec/usermin
	dodir /usr/sbin
	mv *.* ${D}/usr/libexec/usermin
	mv * ${D}/usr/libexec/usermin
	exeinto /etc/init.d
	newexe ${FILESDIR}/patch/usermin usermin
	exeinto /usr/libexec/usermin
	newexe ${FILESDIR}/patch/setup.sh setup.sh
	newexe ${FILESDIR}/patch/usermin-init usermin-init
	dosym /usr/libexec/usermin /etc/usermin
	dosym /usr/libexec/usermin/usermin-init /usr/sbin/usermin

	insinto /etc/pam.d
	newins ${FILESDIR}/${PN}.pam ${PN}
	
}

pkg_postinst() {
	einfo "Configure usermin by running \"usermin setup\"."
	echo
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

pkg_prerm() {
	usermin stop
}

pkg_postrm() {
	/usr/libexec/usermin/uninstall.sh
}

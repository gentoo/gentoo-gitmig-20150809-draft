# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.000.ebuild,v 1.6 2004/01/05 12:55:44 weeve Exp $

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc"
IUSE="ssl"

DEPEND="dev-lang/perl
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

#pkg_postrm() {
#	/usr/libexec/usermin/uninstall.sh
#}

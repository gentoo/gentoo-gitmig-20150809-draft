# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpsysinfo/phpsysinfo-2.1-r1.ebuild,v 1.4 2004/01/05 10:40:49 trance Exp $

MY_PN="phpSysInfo"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="phpSysInfo is a nice package that will display your system stats via PHP."
HOMEPAGE="http://phpsysinfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/phpsysinfo/${MY_P}.tar.gz
http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}-${PR/r}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha hppa"
IUSE=""
DEPEND=">=apache-1.3.27-r1 >=mod_php-4.2.3-r2"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	epatch ${DISTDIR}/${PN}_${PV}-${PR/r}.diff.gz
	mv ${P}/debian ${S}
	rmdir ${P}
	epatch ${S}/debian/patches/urlencoded-security-fix.diff
}
src_install() {
	HTDOCS="/var/www/localhost/htdocs"
	insinto ${HTDOCS}/phpsysinfo
	doins *.{php,dtd}
	cp -pR templates ${D}${HTDOCS}/phpsysinfo
	cp -pR includes  ${D}${HTDOCS}/phpsysinfo
	dodoc COPYING  ChangeLog  README debian/patches/fix_memory_display_kernel2.5.diff
}

pkg_postinst() {
	einfo "Your stats are now available at http://yourserver/phpsysinfo"
	einfo "If you use a 2.5 kernel and want correct memory details output,"
	einfo "please apply /usr/share/doc/${PF}/fix_memory_display_kernel2.5.diff.gz"
	einfo "to the application."
}

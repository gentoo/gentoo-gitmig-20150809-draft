# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpsysinfo/phpsysinfo-2.1-r2.ebuild,v 1.4 2004/03/29 15:45:00 stuart Exp $

inherit eutils kernel-mod

MY_PN="phpSysInfo"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="phpSysInfo is a nice package that will display your system stats via PHP."
HOMEPAGE="http://phpsysinfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/phpsysinfo/${MY_P}.tar.gz
	mirror://debian/pool/main/p/phpsysinfo/${PN}_${PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha hppa sparc amd64"

DEPEND=">=net-www/apache-1.3.27-r1
	>=dev-php/mod_php-4.2.3-r2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	epatch ${DISTDIR}/${PN}_${PV}-1.diff.gz
	mv ${P}/debian ${S}
	rmdir ${P}
	epatch ${S}/debian/patches/urlencoded-security-fix.diff

	APPLY_25PATCH=-1
	kernel-mod_is_2_4_kernel && APPLY_25PATCH=0
	[ "APPLY_25PATCH" = "-1" ] && kernel-mod_is_2_5_kernel && APPLY_25PATCH=1
	[ "APPLY_25PATCH" = "-1" ] && kernel-mod_is_2_6_kernel && APPLY_25PATCH=1
	[ "$APPLY_25PATCH" = "1" ] && epatch ${FILESDIR}/fix_memory_display_kernel2.5.diff.gz
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	HTDOCS="/var/www/localhost/htdocs"
	insinto ${HTDOCS}/phpsysinfo
	doins *.{php,dtd}
	cp -pR templates ${D}${HTDOCS}/phpsysinfo
	cp -pR includes  ${D}${HTDOCS}/phpsysinfo
	dodoc COPYING  ChangeLog  README
}

pkg_postinst() {
	einfo "Your stats are now available at http://localhost/phpsysinfo"
}

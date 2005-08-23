# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pxes/pxes-0.6-r4.ebuild,v 1.14 2005/08/23 19:26:05 wolf31o2 Exp $

inherit perl-module

IUSE="cdr ltsp"
DESCRIPTION="PXES is a package for building thin clients using multiple types of clients"
HOMEPAGE="http://pxes.sourceforge.net"
SRC_URI="mirror://sourceforge/pxes/${PN}-base-i586-${PV}-4.tar.gz
	mirror://sourceforge/pxes/pxesconfig-${PV}-4.tar.gz
	ltsp? ( mirror://sourceforge/pxes/${PN}-ltsp-${PV}.tar.gz )"

KEYWORDS="x86"

SLOT="0"
LICENSE="GPL-2"
DEPEND=">=dev-lang/perl-5.8.0-r12
	ltsp? ( >=net-misc/ltsp-3.0.9-r1 )"

RDEPEND="${DEPEND}
	dev-perl/gtk-perl
	>=dev-perl/glade-perl-0.61
	cdr? ( app-cdr/cdrtools )"

RESTRICT="nouserpriv"

dir=/opt/${P}
Ddir=${D}/${dir}

src_unpack() {
	unpack ${A}

	use ltsp && unpack ${PN}-ltsp-${PV}.tar.gz
}

src_compile() {
	cd ${WORKDIR}/pxesconfig-${PV}
	perl-module_src_compile || die
}

src_install() {
	dodir ${dir}
	cp -pPR ${S}/stock ${Ddir}
	cp -pPR ${S}/tftpboot ${D}
	dodoc Documentation/ChangeLog
	dohtml -r Documentation/html/*
	exeinto ${dir}
	doexe ${FILESDIR}/makedevices.sh
	cd ${WORKDIR}/pxesconfig-${PV}
	perl-module_src_install || die
	dosym /usr/bin/cpio /bin/cpio
}

#pkg_postinst() {
#	${dir}/makedevices.sh
#}

#pkg_prerm() {
#	rm -rf ${dir}/stock/{dist,initrd}/dev
#}

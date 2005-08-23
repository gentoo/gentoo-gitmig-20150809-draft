# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pxes/pxes-0.8.ebuild,v 1.10 2005/08/23 19:26:05 wolf31o2 Exp $

inherit perl-module

IUSE="cdr"
DESCRIPTION="PXES is a package for building thin clients using multiple types of clients"
HOMEPAGE="http://pxes.sourceforge.net"
SRC_URI="mirror://sourceforge/pxes/${PN}-base-i586-${PV}-9.tar.gz
	mirror://sourceforge/pxes/pxesconfig-${PV}-9.tar.gz"

KEYWORDS="x86"

SLOT="0"
LICENSE="GPL-2"
DEPEND=">=dev-lang/perl-5.8.0-r12"

RDEPEND="${DEPEND}
	dev-perl/gtk-perl
	>=dev-perl/glade-perl-0.61
	sys-fs/squashfs-tools
	cdr? ( app-cdr/cdrtools )"


dir=/opt/${P}
Ddir=${D}/${dir}

src_unpack() {
	unpack ${A} || die "Unpacking"
#	use ltsp && unpack ${PN}-ltsp-${PV}-9.tar.gz
}

src_compile() {
	cd ${WORKDIR}/pxesconfig-${PV}
	SRC_PREP="yes"
	perl Makefile.PL PREFIX=${D}/usr INSTALLDIRS=vendor DESTDIR=${D}
	perl-module_src_compile || die
}

src_install() {
	dodir ${dir}
	cd ${Ddir}
	cp -r ${S}/stock ${Ddir} || die "Copying files"
	cp -pPR ${S}/tftpboot ${D}
	dodoc Documentation/ChangeLog
	dohtml -r Documentation/html/*
	cd ${WORKDIR}/pxesconfig-${PV}
	perl-module_src_install || die
	dosym /usr/bin/cpio /bin/cpio
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pxes/pxes-0.6.ebuild,v 1.4 2003/09/05 22:13:37 msterret Exp $

IUSE="ltsp"
DESCRIPTION="PXES is a package for building thin clients using multiple types of clients"
SRC_URI="mirror://sourceforge/pxes/${PN}-base-i586-${PV}.tar.gz
	mirror://sourceforge/pxes/pxesconfig-${PV}.tar.gz
	mirror://sourceforge/pxes/pxelinux.0
	ltsp? ( mirror://sourceforge/pxes/${PN}-ltsp-${PV}.tar.gz )"

SLOT="0"
KEYWORDS="x86"

LICENSE="GPL-2"
DEPEND=">=dev-lang/perl-5.8.0-r12
	ltsp? >=net-misc/ltsp-core-3.0.9-r1"
RDEPEND="${DEPEND}
	>=dev-perl/glade-perl-0.61"

S=${WORKDIR}/${P}

inherit perl-module

dir=/opt/${P}
Ddir=${D}/${dir}

src_unpack() {
	tar -xzf ${DISTDIR}/${PN}-base-i586-${PV}.tar.gz \
	--no-same-permissions \
	--exclude=pxes-0.6/stock/dist/dev/* \
	--exclude=pxes-0.6/stock/initrd/dev/*

	unpack pxesconfig-${PV}.tar.gz
	use ltsp && unpack ${PN}-ltsp-${PV}.tar.gz
}

src_compile() {
	cd ${WORKDIR}/pxesconfig-${PV}
	epatch ${FILESDIR}/${P}-gentoo.patch
	perl Makefile.PL PREFIX=${D}/usr || die
	make
}

src_install() {
	dodir ${dir}
	cp -r ${S}/stock ${Ddir}
	cp -r ${S}/tftpboot ${D}
	cp ${DISTDIR}/pxelinux.0 ${D}/tftpboot/pxes
	dodoc Documentation/ChangeLog
	dohtml Documentation/html/{index,pxe,readme,screenshots}.html,howto/{configuring_ICA,customizing_kernel_and_modules,gdm,xfs,ms_only_environment/ms_only_environment}.html
	exeinto ${dir}
	doexe ${FILESDIR}/makedevices.sh
	cd ${WORKDIR}/pxesconfig-${PV}
	perl-module_src_install || die
}

pkg_postinst() {
	${dir}/makedevices.sh
}

pkg_prerm() {
	rm -rf ${dir}/stock/{dist,initrd}/dev
}

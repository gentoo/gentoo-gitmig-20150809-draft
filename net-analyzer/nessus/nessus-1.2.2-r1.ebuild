# Copyright 2000-2002 Achim Gottinger
# Distributed under the GPL by Gentoo Technologies, Inc.
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-1.2.2-r1.ebuild,v 1.2 2002/07/18 23:22:50 seemant Exp $

S=${WORKDIR}
DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org/"

SRC_URI="ftp://ftp.nessus.org/pub/${PN}/${P}/src/${PN}-libraries-${PV}.tar.gz
	 ftp://ftp.nessus.org/pub/${PN}/${P}/src/${PN}-core-${PV}.tar.gz
	 ftp://ftp.nessus.org/pub/${PN}/${P}/src/${PN}-plugins-${PV}.tar.gz
	 ftp://ftp.nessus.org/pub/${PN}/${P}/src/libnasl-${PV}.tar.gz"

DEPEND="virtual/x11
	sys-devel/m4
	>=dev-libs/gmp-3.1.1
	>=sys-libs/zlib-1.1.4
	=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"


src_compile() {

	export PATH=${D}/usr/bin:$PATH
	export LD_LIBRARY_PATH=${D}/usr/lib:$LD_LIBRARY_PATH

	echo "Compiling libraries..."
	cd ${S}/nessus-libraries
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state \
		--mandir=/usr/share/man \
		--enable-pthread || die "Configure failed"

	make || die "Compile failed nessus-libraries."

	cd ${D}/usr/bin
	cp nessus-config nessus-config.orig
	sed -e "s:^PREFIX=:PREFIX=${D}:" \
		-e "s:-I/usr:-I${D}/usr: " \
		nessus-config.orig > nessus-config

	echo "Compiling libnasl..."
	cd ${S}/libnasl
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state \
		--mandir=/usr/share/man	|| die "Configure failed libnasl"

	make || die "Compile failed libnasl. (Try unmerging nessus-1.0.* if installed.)"

	cd ${D}/usr/bin
	cp nasl-config nasl-config.orig
	sed -e "s:^PREFIX=:PREFIX=${D}:" nasl-config.orig > nasl-config

	echo "Compiling core..."
	cd ${S}/nessus-core
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state \
		--mandir=/usr/share/man || die "Configure failed nessus-core"

	make || die "Compile failed nessus-core"

	echo "Compiling plugins..."
	cd ${S}/nessus-plugins
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state \
		--mandir=/usr/share/man || die "Configure failed nessus-plugins"

	make || die "Compile failed nessus-pluggins"

}

src_install() {

	cd ${S}/nessus-libraries
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "Install failed nessus-libraries."

	cd ${S}/libnasl
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "Install failed libnasl"

	cd ${S}/nessus-core
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "Install failed nessus-core"

	cp ${ROOT}/config/nessusd.conf ${D}/etc/nessus/

	cd ${S}/nessus-plugins
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "Install failed nessus-pluggins"

	cd ${S}/nessus-libraries
	docinto nessus-libraries
	dodoc README*

	cd ${S}/libnasl
	docinto libnasl
	dodoc COPYING TODO

	cd ${S}/nessus-core
	docinto nessus-core
	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*

	cd ${S}/nessus-plugins
	docinto nessus-plugins
	dodoc docs/*.txt plugins/accounts/accounts.txt

	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/nessusd-r6 nessusd
}

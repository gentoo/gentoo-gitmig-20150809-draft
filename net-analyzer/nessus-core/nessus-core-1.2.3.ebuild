# Copyright 2000-2002 Achim Gottinger
# Distributed under the GPL by Gentoo Technologies, Inc.
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-1.2.3.ebuild,v 1.1 2002/07/26 19:56:59 raker Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"

SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-1.2.3/src/${P}.tar.gz"

DEPEND="=net-analyzer/libnasl-1.2.3
	X? ( x11-base/xfree )
	gtk? ( x11-libs/gtk-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc -sparc64"

src_compile() {

	use X && myconf="--with-x" || myconf="--without-x"

	use gtk && myconf="--enable-gtk" || myconf="--disable-gtk" 

	econf || die "configure failed"

	emake || die "emake failed"

}

src_install() {

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "Install failed nessus-core"

	cp ${ROOT}/config/nessusd.conf ${D}/etc/nessus/

	cd ${S}
	docinto nessus-core
	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*

	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/nessusd-r6 nessusd
}

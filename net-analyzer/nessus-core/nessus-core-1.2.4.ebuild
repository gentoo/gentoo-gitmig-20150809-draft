# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-1.2.4.ebuild,v 1.6 2002/10/05 05:39:17 drobbins Exp $

IUSE="X gtk"

S=${WORKDIR}/${PN}

DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

DEPEND="=net-analyzer/libnasl-1.2.4
	X? ( x11-base/xfree )
	gtk? ( =x11-libs/gtk+-1.2* )"
RDEPEND="${DEPEND}"

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
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "Install failed nessus-core"

	cd ${S}
	docinto nessus-core
	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*

	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/nessusd-r6 nessusd

	keepdir /var/lib/nessus/logs
	keepdir /var/lib/nessus/users

}

# Copyright 2002 Gentoo Technologies, Inc
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smartsuite/smartsuite-2.1-r1.ebuild,v 1.1 2002/08/27 00:11:33 agenkin Exp $

DESCRIPTION="Suite to control and monitor storage devices using SMART technology."
HOMEPAGE="http://www.linux-ide.org/smart.html"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
SRC_URI="mirror://sourceforge/smartsuite/${P}.tar.gz
	http://www.linux-ide.org/smart/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {

	unpack "${A}"
	cd "${S}"
	sed -e "/^CFLAGS/ s/-O2/$CFLAGS/" < Makefile > Makefile.hacked
	mv Makefile.hacked Makefile

}

src_compile() {

	emake || die

}

src_install() {

	into /
	dosbin smartctl smartd

	into /usr
	doman smartctl.8 smartd.8
	dodoc CHANGELOG TODO COPYING README

	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/smartd.rc smartd

}

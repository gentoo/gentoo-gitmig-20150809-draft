# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.11.ebuild,v 1.18 2005/03/18 11:54:06 liquidx Exp $

inherit gnuconfig

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org/"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa -amd64 ia64 s390 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# needed at least by alpha and amd64
	gnuconfig_update
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS FAQ ChangeLog NEWS README* THANKS
	rm -rf ${D}/usr/doc
	dohtml -r .
	exeinto /etc/init.d
	newexe ${FILESDIR}/slpd-init slpd
}

src_test() {
	return
}
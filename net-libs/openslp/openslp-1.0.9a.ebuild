# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.9a.ebuild,v 1.11 2005/03/18 04:40:28 kugelfang Exp $

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org"

SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

KEYWORDS="x86 sparc ppc hppa -amd64"
IUSE=""
DEPEND="virtual/libc"

SLOT="0"
LICENSE="BSD"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS FAQ COPYING ChangeLog NEWS README* THANKS
	rm -rf ${D}/usr/doc
	dohtml -r .
	exeinto /etc/init.d
	newexe ${FILESDIR}/slpd-init slpd
}

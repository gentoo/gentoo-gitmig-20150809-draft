# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.11.ebuild,v 1.1 2003/03/26 22:02:54 liquidx Exp $

IUSE=""

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

KEYWORDS="~x86 ~sparc ~ppc ~hppa"
DEPEND="virtual/glibc"
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

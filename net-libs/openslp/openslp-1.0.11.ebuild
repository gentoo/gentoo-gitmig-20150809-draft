# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.11.ebuild,v 1.3 2003/07/18 22:04:42 tester Exp $

inherit gnuconfig

IUSE=""

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

KEYWORDS="x86 ~sparc ~ppc ~hppa amd64"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="BSD"

src_unpack() {
	unpack ${A}

	use amd64 && gnuconfig_update
}

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

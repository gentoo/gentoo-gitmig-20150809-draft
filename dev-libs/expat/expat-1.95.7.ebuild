# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.7.ebuild,v 1.15 2004/07/14 14:19:00 agriffis Exp $

inherit gnuconfig

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips alpha arm ~hppa amd64 ~ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	# Detect mips systems properly
	gnuconfig_update

	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall mandir=${D}/usr/share/man/man1 || die
	dodoc Changes README
	dohtml doc/
}

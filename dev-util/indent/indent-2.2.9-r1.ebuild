# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.9-r1.ebuild,v 1.4 2004/10/27 16:26:09 vapier Exp $

inherit gnuconfig

DESCRIPTION="Indent program source files"
HOMEPAGE="http://www.gnu.org/software/indent/indent.html"
SRC_URI="mirror://gnu/indent/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="nls"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README*
	dohtml "${D}/usr/doc/indent/"*
	rm -rf "${D}/usr/doc"
}

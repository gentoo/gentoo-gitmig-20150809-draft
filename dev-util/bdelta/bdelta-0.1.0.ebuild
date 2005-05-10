# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bdelta/bdelta-0.1.0.ebuild,v 1.3 2005/05/10 20:06:11 herbs Exp $

inherit multilib

DESCRIPTION="Binary Delta - Efficient difference algorithm and format"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/deltup/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

src_unpack() {
	unpack ${A}
	# Set correct libdir
	sed -i -e "s:\(LIBDIR=\${PREFIX}/\)lib:\1$(get_libdir):" \
		${S}/Makefile || die "sed failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/$(get_libdir)
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
}

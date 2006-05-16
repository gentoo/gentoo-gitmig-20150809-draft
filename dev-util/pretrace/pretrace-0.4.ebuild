# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pretrace/pretrace-0.4.ebuild,v 1.2 2006/05/16 19:31:53 taviso Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Start dynamically linked applications under debugging environment"
HOMEPAGE="http://dev.inversepath.com/trac/pretrace"
SRC_URI="http://dev.inversepath.com/pretrace/libpretrace-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="virtual/libc"
S="${WORKDIR}/lib${P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}--as-needed.diff
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/share/man/man{3,8}
	dodir /usr/bin

	einstall LIBDIR=${D}/lib PREFIX=${D}/usr || die
	prepalldocs
}

pkg_postinst() {
	einfo "remember to execute ptgenmap after modifying pretrace.conf"
}

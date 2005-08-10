# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-1.8.ebuild,v 1.3 2005/08/10 22:17:54 sbriesen Exp $

DESCRIPTION="Expanded md5sum program that has recursive and comparison options."
HOMEPAGE="http://md5deep.sourceforge.net"
SRC_URI="mirror://sourceforge/md5deep/${P}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~ppc-macos"
IUSE=""
DEPEND=""

src_compile() {
	sed -i -e "s:-Wall -O2:\$(CFLAGS):g" Makefile
	use userland_Darwin && BUILDTARGET="mac" || BUILDTARGET="linux"
	emake CFLAGS="${CFLAGS}" "${BUILDTARGET}" || die "make failed"
}

src_install() {
	make BIN="${D}/usr/bin" MAN="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES README
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.66.ebuild,v 1.5 2004/10/26 20:57:02 eldad Exp $

inherit toolchain-funcs

DESCRIPTION="Flow-tools is a package for collecting and processing NetFlow data"
HOMEPAGE="http://www.splintered.net/sw/flow-tools/"
SRC_URI="ftp://ftp.eng.oar.net/pub/flow-tools/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/libc
	sys-apps/tcp-wrappers
	sys-libs/zlib"

src_compile() {
	aclocal
	automake
	econf \
		--without-mysql \
		--localstatedir=/etc/flow-tools \
		CC="$(tc-getCC)" CFLAGS="$CFLAGS" || die
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS" || die
}

src_install() {
	einstall localstatedir=$D/etc/flow-tools CC="$(tc-getCC)" CFLAGS="$CFLAGS"
	dodoc AUTHORS COPYING NEWS ChangeLog README INSTALL SECURITY TODO
}

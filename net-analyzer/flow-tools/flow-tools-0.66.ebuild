# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.66.ebuild,v 1.1 2003/05/18 20:02:51 mholzer Exp $

DESCRIPTION="Flow-tools is a package for collecting and processing NetFlow data"
HOMEPAGE="http://www.splintered.net/sw/flow-tools/"
SRC_URI="ftp://ftp.eng.oar.net/pub/flow-tools/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc sys-apps/tcp-wrappers sys-libs/zlib"

S=${WORKDIR}/${P}

src_compile() {
	aclocal
	automake
	econf \
		--without-mysql \
		--localstatedir=/etc/flow-tools \
		CC="$CC" CFLAGS="$CFLAGS" || die
	emake CC="$CC" CFLAGS="$CFLAGS" || die
}

src_install() {
	einstall localstatedir=$D/etc/flow-tools CC="$CC" CFLAGS="$CFLAGS"
	dodoc AUTHORS COPYING NEWS ChangeLog README INSTALL SECURITY TODO
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/gnustep-make-1.7.1.ebuild,v 1.1 2004/07/23 13:51:21 fafhrd Exp $

IUSE=""

DESCRIPTION="GNUstep makefile package"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-x86"

DEPEND="virtual/libc
	>=sys-devel/gcc-3.2
	>=dev-libs/ffcall-1.8d
	>=dev-libs/gmp-4.1
	>=dev-util/guile-1.6
	>=dev-libs/openssl-0.9.6j
	>=media-libs/tiff-3.5.7-r1
	>=dev-libs/libxml2-2.4.24
	>=media-libs/audiofile-0.2.3"

src_compile() {
	./configure \
		--prefix=/usr/GNUstep \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} || die "./configure failed"
	make || die
}

src_install() {
	make \
	GNUSTEP_SYSTEM_ROOT=${D}/usr/GNUstep/System \
	GNUSTEP_LOCAL_ROOT=${D}/usr/GNUstep/Local \
	GNUSTEP_NETWORK_ROOT=${D}/usr/GNUstep/Network \
	install || die "install failed"
}

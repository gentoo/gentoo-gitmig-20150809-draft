# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-make/gnustep-make-1.7.2.ebuild,v 1.3 2004/01/29 16:21:31 agriffis Exp $

IUSE="X"

DESCRIPTION="GNUstep makefile package"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc
	>=sys-devel/gcc-3.2
	>=dev-libs/ffcall-1.8d
	>=dev-libs/gmp-4.1
	>=dev-util/guile-1.6
	>=dev-libs/openssl-0.9.6j
	>=media-libs/tiff-3.5.7-r1
	>=dev-libs/libxml2-2.4.24
	>=media-libs/audiofile-0.2.3"

src_unpack() {
	ewarn ""
	ewarn "Unmerge previous versions of gnustep-make before upgrading"
	ewarn "or you will have problems!"  See:
	ewarn "http://bugs.gentoo.org/show_bug.cgi?id=24530"
	ewarn ""
	sleep 5
	unpack ${A}
	cd ${S}
}

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

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libarchive/libarchive-1.02.027-r1.ebuild,v 1.1 2005/08/13 15:34:27 flameeyes Exp $

inherit eutils

DESCRIPTION="Library to create and read several different archive formats."
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive/"
SRC_URI="http://people.freebsd.org/~kientzle/libarchive/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

RDEPEND="app-arch/bzip2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Make libarchive compilable on OSX
	epatch ${FILESDIR}/${P}-osx.patch
	# Build with libtool to build shared library
	epatch ${FILESDIR}/${P}-libtool.patch

	touch NEWS README AUTHORS ChangeLog COPYING

	libtoolize --copy --force || die "libtoolize failed"
	autoreconf -i || die "autoreconf failed"
}

src_install() {
	make DESTDIR="${D}" install

	dodir /$(get_libdir)
	mv ${D}/usr/$(get_libdir)/*.so* ${D}/$(get_libdir)
	gen_usr_ldscript libarchive.so
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.3-r2.ebuild,v 1.4 2004/08/02 11:51:52 vapier Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Id3 library for C/C++"
HOMEPAGE="http://id3lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha hppa amd64 ~ia64"
IUSE="doc"

RDEPEND="virtual/libc"
DEPEND="sys-devel/autoconf
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}

	export WANT_AUTOMAKE=1.6
	export WANT_AUTOCONF=2.5

	libtoolize --force --copy || die
	aclocal || die
	automake || die
	autoconf || die
}

src_compile() {
	export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"
	dosym /usr/lib/libid3-3.8.so.3 /usr/lib/libid3-3.8.so.0.0.0
	dosym /usr/lib/libid3-3.8.so.0.0.0 /usr/lib/libid3-3.8.so.0

	dodoc AUTHORS ChangeLog HISTORY INSTALL README THANKS TODO

	# some example programs to be placed in docs dir.
	if use doc; then
		cp -a examples ${D}/usr/share/doc/${PF}/examples
		cd ${D}/usr/share/doc/${PF}/examples
		make distclean
	fi
}

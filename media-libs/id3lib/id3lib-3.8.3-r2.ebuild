# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.3-r2.ebuild,v 1.2 2004/07/11 20:32:01 kloeri Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Id3 library for C/C++"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://id3lib.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc sparc alpha ~hppa amd64 ~ia64 ~mips"

IUSE=""

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

	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL README THANKS TODO
#	some example programs to be placed in docs dir.
	make clean
	cp -a examples ${D}/usr/share/doc/${PF}/examples
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.3-r3.ebuild,v 1.4 2004/11/11 23:30:27 vapier Exp $

inherit eutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Id3 library for C/C++"
HOMEPAGE="http://id3lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-zlib.patch

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
	make DESTDIR="${D}" install || die "Install failed"
	dosym /usr/$(get_libdir)/libid3-3.8.so.3 /usr/$(get_libdir)/libid3-3.8.so.0.0.0
	dosym /usr/$(get_libdir)/libid3-3.8.so.0.0.0 /usr/$(get_libdir)/libid3-3.8.so.0

	dodoc AUTHORS ChangeLog HISTORY INSTALL README THANKS TODO

	# some example programs to be placed in docs dir.
	if use doc; then
		cp -a examples ${D}/usr/share/doc/${PF}/examples
		cd ${D}/usr/share/doc/${PF}/examples
		make distclean
	fi
}

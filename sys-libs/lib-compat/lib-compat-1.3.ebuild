# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.3.ebuild,v 1.6 2004/10/08 03:13:47 vapier Exp $

DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE="sdl"

DEPEND="virtual/libc"

S=${WORKDIR}/${P}/${ARCH}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Rather install this with the proper filename
	mv -f libstdc++-libc6.2-2.so.3 libstdc++-3-libc6.2-2-2.10.0.so
	# libstdc++-2-libc6.1-1-2.9.0.so provides this one ...
	rm -f libstdc++-libc6.1-1.so.2
	# No package installs this one, so no need for the .dummy
	mv -f libstdc++.so.2.9.dummy libstdc++.so.2.9.0
	# dont install if they dont want sdl
	use sdl || rm -f libsmpeg-0.4.so.0.dummy
}

src_install() {
	into /usr
	dolib.so *.so*
	preplib /usr
}

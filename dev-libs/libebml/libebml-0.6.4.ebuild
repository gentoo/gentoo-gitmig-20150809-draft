# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libebml/libebml-0.6.4.ebuild,v 1.9 2004/07/14 14:36:08 agriffis Exp $

inherit flag-o-matic

IUSE=""


DESCRIPTION="Extensible binary format library (kinda like XML)"
SRC_URI="http://matroska.free.fr/downloads/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.matroska.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~alpha ~ia64 ~sparc ~hppa ~mips"

DEPEND="virtual/libc"

src_compile() {
	cd ${S}/make/linux

	# This fix is necessary due to libebml being used to generate
	# shared libraries, such as the vlc plugin for mozilla. on archs
	# that require shared objects to be compiled with -fPIC, this
	# really shouldn't happen, but libebml doesn't produce an so.
	# Travis Tilley <lv@gentoo.org>
	append-flags -fPIC

	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
	make PREFIX=/usr || die "make failed"
}

src_install () {
	cd ${S}/make/linux
	einstall || die "make install failed"
	dodoc ${S}/LICENSE.*
}

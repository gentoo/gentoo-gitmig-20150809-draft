# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyvorbis/pyvorbis-1.4-r3.ebuild,v 1.1 2007/09/19 23:37:53 hawking Exp $

inherit distutils eutils

DESCRIPTION="Python bindings for the ogg.vorbis library"
HOMEPAGE="http://ekyo.nerim.net/software/pyogg/"
SRC_URI="http://ekyo.nerim.net/software/pyogg/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/python
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0
	>=dev-python/pyogg-1.1"

DOCS="AUTHORS COPYING ChangeLog NEWS README"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}/pyvorbisfile.c-1.4.patch"
	epatch "${FILESDIR}/${P}-python25.patch"
}

src_compile() {
	./config_unix.py || die
	distutils_src_compile
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}

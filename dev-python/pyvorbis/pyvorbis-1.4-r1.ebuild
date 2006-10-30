# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyvorbis/pyvorbis-1.4-r1.ebuild,v 1.12 2006/10/30 02:51:23 the_paya Exp $

inherit distutils eutils

DESCRIPTION="Python bindings for the ogg.vorbis library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/python
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0
	>=dev-python/pyogg-1.1"

DOCS="AUTHORS COPYING ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pyvorbisfile.c-1.4.patch
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

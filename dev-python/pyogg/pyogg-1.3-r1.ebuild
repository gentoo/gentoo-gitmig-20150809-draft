# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyogg/pyogg-1.3-r1.ebuild,v 1.12 2006/10/30 02:49:10 the_paya Exp $

inherit distutils

DESCRIPTION="Python bindings for the ogg library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
# Grumble. They changed the tarball without changing the name..
#SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~kloeri/${P}-r1.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/python
	>=media-libs/libogg-1.0"

DOCS="AUTHORS COPYING ChangeLog NEWS README"

src_compile() {
	./config_unix.py || die
	distutils_src_compile
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}

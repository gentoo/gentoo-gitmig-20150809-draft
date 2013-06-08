# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyogg/pyogg-1.3-r2.ebuild,v 1.1 2013/06/08 19:39:05 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 multilib toolchain-funcs

DESCRIPTION="Python bindings for the ogg library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
# Grumble. They changed the tarball without changing the name..
#SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}-r1.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/libogg-1.0"
RDEPEND="${DEPEND}"

DOCS=( COPYING ChangeLog )

python_configure_all() {
	tc-export CC
	cat > Setup <<-EOF
	ogg_libs = ogg
	ogg_lib_dir = /usr/$(get_libdir)
	ogg_include_dir = /usr/include
	EOF
}

python_install_all() {
	distutils-r1_python_install_all
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adaopengl/adaopengl-0.12.ebuild,v 1.1 2003/08/14 02:13:33 dholm Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="This is an Ada-binding to OpenGL and some of it's related libraries."
SRC_URI="mirror://sourceforge/adaopengl/${P}.tar.bz2"
HOMEPAGE="http://adaopengl.sourceforge.net/"
LICENSE="BSD"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lang/gnat
	dev-ada/adabindx"
RDEPEND="virtual/opengl"

inherit gnat

src_compile() {
	# This should not be here ;)
	rm ${S}/adaopengl/adagl.ads

	emake || die
}

src_install () {
	make PREFIX=${D}/usr install || die

	# Install documentation.
	dodoc Changelog COPYING Readme TODO
}

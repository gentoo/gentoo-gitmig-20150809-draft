# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glfw/glfw-2.4.2.ebuild,v 1.1 2005/03/09 04:32:56 mr_bones_ Exp $

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="http://glfw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86"
IUSE="examples"

DEPEND="virtual/x11
	virtual/opengl"

src_compile() {
	emake x11 || die "emake failed"
}

src_install() {
	dolib.a lib/x11/libglfw.a || die "dolib.a failed"

	insinto /usr/include/GL
	doins include/GL/glfw.h || die "doins failed"
	dohtml readme.html
	insinto /usr/share/doc/${PF}/pdf
	doins docs/*.pdf

	if use examples; then
		local f
		local MY_EXAMPLES="boing gears keytest listmodes mipmaps
			mtbench mthello particles pong3d splitview
			triangle wave"
		local MY_PICS="mipmaps.tga pong3d_field.tga pong3d_instr.tga
			pong3d_menu.tga pong3d_title.tga
			pong3d_winner1.tga pong3d_winner2.tga"

		insinto /usr/share/doc/${PF}/examples

		for f in $MY_EXAMPLES; do
			doins examples/${f}.c
		done
		for f in $MY_PICS; do
			doins examples/${f}
		done

		insopts -m0755
		for f in $MY_EXAMPLES; do
			doins examples/${f}
		done
	fi
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-2.2.1.ebuild,v 1.7 2006/09/10 22:54:53 wormo Exp $

DESCRIPTION="Open Source Graph Visualization Software"
HOMEPAGE="http://www.graphviz.org/"
SRC_URI="http://www.graphviz.org/pub/graphviz/ARCHIVE/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~x86"
IUSE="dynagraph tcltk X"

RDEPEND=">=sys-libs/zlib-1.1.3
		 >=media-libs/libpng-1.2
		 >=media-libs/jpeg-6b
		   media-libs/freetype
		   media-libs/fontconfig
		   dev-libs/expat
		   sys-libs/zlib
		   sys-devel/gettext
		 tcltk? ( >=dev-lang/tk-8.3 )"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {
	econf --with-mylibgd \
		  $(use_with dynagraph dynagraph) \
		  $(use_with tcltk tcl) $(use_with tcltk tk) \
		  $(use_with X x) || die "Configure Failed!"
	emake || die "Compile Failed!"
}

src_install() {
	make DESTDIR=${D} install || die "Install Failed!"

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc doc/*.pdf doc/Dot.ref
	dohtml -r .
}

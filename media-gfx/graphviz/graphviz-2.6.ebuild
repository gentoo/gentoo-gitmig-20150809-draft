# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-2.6.ebuild,v 1.9 2006/05/28 02:44:07 nerdboy Exp $

inherit eutils

DESCRIPTION="Open Source Graph Visualization Software"
HOMEPAGE="http://www.graphviz.org/"
SRC_URI="http://www.graphviz.org/pub/graphviz/ARCHIVE/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="cairo tcltk X static"

RDEPEND=">=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2
	>=media-libs/jpeg-6b
	media-libs/freetype
	media-libs/fontconfig
	dev-libs/expat
	sys-libs/zlib
	tcltk? ( >=dev-lang/tk-8.3 )
	cairo? ( >=x11-libs/libsvg-cairo-0.1.3 )
	X? ( || (
	    ( x11-libs/libXaw x11-libs/libXpm )
	virtual/x11 )
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-no-undefined.patch || die "epatch failed"
	epatch ${FILESDIR}/${P}-macos.patch || die "epatch failed"
}

src_compile() {
	econf --with-mylibgd \
		--disable-dependency-tracking \
		$(use_enable static) \
		$(use_with tcltk tcl) \
		$(use_with tcltk tk) \
		$(use_with X x) || die "Configure Failed!"
	emake || die "Compile Failed!"
}

src_install() {
	make DESTDIR=${D} \
		docdir=${D}/usr/share/doc/${PN} \
		pkgconfigdir=/usr/$(get_libdir)/pkgconfig \
		install || die "Install Failed!"

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc doc/*.pdf doc/Dot.ref
	dohtml -r .
}

pkg_postinst() {
	dot -c
}

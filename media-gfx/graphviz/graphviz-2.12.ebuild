# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-2.12.ebuild,v 1.1 2007/02/12 23:58:01 dev-zero Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils autotools multilib

DESCRIPTION="Open Source Graph Visualization Software"
HOMEPAGE="http://www.graphviz.org/"
SRC_URI="http://www.graphviz.org/pub/graphviz/ARCHIVE/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="cairo doc examples gtk tcl tk X guile java lua pango perl php python ruby ocaml"

RDEPEND="
	>=media-libs/gd-2.0.28
	>=sys-libs/zlib-1.2.3
	>=media-libs/freetype-2.1.3
	>=media-libs/libpng-1.2.5
	>=media-libs/jpeg-6b
	>=dev-libs/expat-1.95.5
	virtual/libiconv
	sys-devel/libtool
	media-libs/fontconfig
	cairo? ( >=x11-libs/libsvg-cairo-0.1.3 )
	pango? ( x11-libs/pango )
	gtk? ( >=x11-libs/gtk+-2 )
	tcl? ( >=dev-lang/tcl-8.3 )
	tk? ( >=dev-lang/tk-8.3 )
	guile? ( dev-scheme/guile )
	java? ( virtual/jdk )
	perl? ( dev-lang/perl )
	ocaml? ( dev-lang/ocaml )
	lua? ( dev-lang/lua )
	php? ( dev-lang/php )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	X? ( x11-libs/libXaw x11-libs/libXpm )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	tcl? ( dev-lang/swig )
	guile? ( dev-lang/swig )
	java? ( dev-lang/swig )
	perl? ( dev-lang/swig )
	ocaml? ( dev-lang/swig )
	lua? ( dev-lang/swig )
	php? ( dev-lang/swig )
	python? ( dev-lang/swig )
	ruby? ( dev-lang/swig )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-notcl.patch"
	epatch "${FILESDIR}/${P}-find-system-libgd.patch"

	sed -i \
		-e 's:LC_COLLATE=C:LC_ALL=C:g' \
		lib/common/Makefile.* || die "sed failed" # bug 134834

	# Make sure SWIG interface is rebuilt
	touch tclpkg/gv/gv.i

	eautoreconf
}

src_compile() {
	# Ming 3.0 is needed but still masked
	econf \
		--disable-dependency-tracking \
		--with-libgd \
		--without-ming \
		$(use_with pango pangocairo) \
		$(use_with gtk) \
		$(use_enable tcl) \
		$(use_enable tk) \
		$(use_enable guile) \
		$(use_enable java) \
		$(use_enable lua) \
		$(use_enable ocaml) \
		$(use_enable perl) \
		$(use_enable php) \
		$(use_enable python) \
		$(use_enable ruby) \
		--disable-{sharp,io} \
		$(use_with X x) \
		|| die "Configure Failed!"
	emake || die "Compile Failed!"
}

src_install() {
	sed -i \
		-e "s:htmldir:htmlinfodir:g" \
		doc/info/Makefile

	emake DESTDIR="${D}" \
		txtdir=/usr/share/doc/${PF} \
		htmldir=/usr/share/doc/${PF}/html \
		htmlinfodir=/usr/share/doc/${PF}/html/info \
		pdfdir=/usr/share/doc/${PF}/pdf \
		pkgconfigdir=/usr/$(get_libdir)/pkgconfig \
		install || die "Install Failed!"

	use doc || rm -rf "${D}/usr/share/doc/${PF}"/{pdf,html}
	use examples || rm -rf "${D}/usr/share/graphviz/demo"

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	dot -c
}

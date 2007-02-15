# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-2.8-r2.ebuild,v 1.11 2007/02/15 17:14:19 chrb Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils libtool autotools

DESCRIPTION="Open Source Graph Visualization Software"
HOMEPAGE="http://www.graphviz.org/"
SRC_URI="http://www.graphviz.org/pub/graphviz/ARCHIVE/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="cairo tcl tk X static guile java lua perl php python ruby ocaml minimal"

RDEPEND=">=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2
	>=media-libs/jpeg-6b
	<media-libs/gd-2.0.34
	media-libs/freetype
	media-libs/fontconfig
	dev-libs/expat
	sys-libs/zlib
	cairo? ( >=x11-libs/libsvg-cairo-0.1.3 )
	tk? ( >=dev-lang/tk-8.3 )
	tcl? ( >=dev-lang/tcl-8.3 )
	guile? ( dev-scheme/guile )
	java? ( virtual/jdk )
	perl? ( dev-lang/perl )
	ocaml? ( dev-lang/ocaml )
	lua? ( dev-lang/lua )
	php? ( dev-lang/php )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	X? ( x11-libs/libXaw x11-libs/libXpm )
	sys-devel/libtool"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	tcl? ( dev-lang/swig )
	tk? ( dev-lang/swig )
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
	epatch "${FILESDIR}"/${P}-notcl.patch
	sed -i 's:LC_COLLATE=C:LC_ALL=C:g' lib/common/Makefile.* #134834

	# Make sure SWIG interface is rebuilt
	touch tclpkg/gv/gv.i

	eautoreconf
}

src_compile() {
	local my_conf
	econf ${my_conf}  \
		--disable-dependency-tracking \
		$(use_enable static) \
		$(use_with tcl) \
		$(use_with tk) \
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
	sed -i -e "s:htmldir:htmlinfodir:g" doc/info/Makefile
	make DESTDIR="${D}" \
		txtdir=/usr/share/doc/${PF} \
		htmldir=/usr/share/doc/${PF}/html \
		htmlinfodir=/usr/share/doc/${PF}/html/info \
		pdfdir=/usr/share/doc/${PF}/pdf \
		pkgconfigdir=/usr/$(get_libdir)/pkgconfig \
		install || die "Install Failed!"
	if use minimal ; then
		rm -rf "${D}"/usr/share/doc/${PF}/{pdf,html}
		rm -rf "${D}"/usr/$(get_libdir)/${PN}/{tcl,lua,perl,python,ruby}
	fi
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	dot -c
}

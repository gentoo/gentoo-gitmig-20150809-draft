# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.11.1.ebuild,v 1.3 2009/10/26 18:13:11 armin76 Exp $

EAPI=2
DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug doc double-precision examples gyroscopic"

RDEPEND="examples? (
		virtual/opengl
		virtual/glu
	)"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i \
		-e "s:\$.*/drawstuff/textures:/usr/share/doc/${PF}/examples:" \
		drawstuff/src/Makefile.in \
		ode/demo/Makefile.in \
		|| die "sed Makefile.in failed"
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		$(use_enable debug asserts) \
		$(use_enable double-precision) \
		$(use_enable examples demos) \
		$(use_enable gyroscopic) \
		$(use_with examples drawstuff X11)
}

src_compile() {
	emake || die "emake failed"
	if use doc ; then
		cd ode/doc
		doxygen Doxyfile || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG.txt README.txt
	if use doc ; then
		dohtml docs/* || die "dohtml failed"
	fi
	if use examples; then
		cd ode/demo
		exeinto /usr/share/doc/${PF}/examples
		local f
		for f in *.c* ; do
			doexe .libs/${f%.*} || die "doexe ${f%.*} failed"
		done
		cd ../..
		doexe drawstuff/dstest/dstest
		insinto /usr/share/doc/${PF}/examples
		doins ode/demo/*.{c,cpp,h} \
			drawstuff/textures/*.ppm \
			drawstuff/dstest/dstest.cpp \
			drawstuff/src/{drawstuff.cpp,internal.h,x11.cpp} \
			|| die "doins failed"
	fi
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-1.2.2-r1.ebuild,v 1.1 2005/07/21 20:45:01 carlo Exp $

inherit eutils

MY_P=OpenEXR-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ILM's HDR image file format libraries"
SRC_URI="http://savannah.nongnu.org/download/openexr/${MY_P}.tar.gz"
HOMEPAGE="http://www.openexr.com"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples fltk"

RDEPEND="virtual/x11
	virtual/opengl
	fltk? ( x11-libs/fltk )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

pkg_setup() {
	if use fltk  && ( ! built_with_use x11-libs/fltk opengl ) ; then
		echo
		eerror "You need either to rebuild x11-libs/fltk with opengl use flag enabled, or to build"
		eerror "OpenEXR without fltk support (exrdisplay, an OpenEXR image viewer won't be built)."
		die
	fi
}

src_unpack() {
	unpack ${A}
	sed -i -e "s:OpenEXR-@OPENEXR_VERSION@:\$\(P\):" ${S}/IlmImfExamples/Makefile.in
	sed -i -e "s:NVSDK_CXXFLAGS=\"\":NVSDK_CXXFLAGS=\"-DUNIX\":" ${S}/acinclude.m4
}

src_compile() {
	local myconf="--disable-fltktest $(use_with fltk fltk-config) $(use_enable examples imfexamples)"
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS Changelog README* INSTALL ChangeLog LICENSE NEWS
	if use examples && [ "${P}" != "${PF}" ] ; then
		mv ${D}/usr/share/doc/${P}/examples ${D}/usr/share/doc/${PF}/examples
	fi
	use doc && dohtml -r ${S}/doc/*
}

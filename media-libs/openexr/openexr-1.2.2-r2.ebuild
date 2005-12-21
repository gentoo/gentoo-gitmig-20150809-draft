# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-1.2.2-r2.ebuild,v 1.2 2005/12/21 21:33:15 mr_bones_ Exp $

inherit eutils

MY_P=OpenEXR-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ILM's HDR image file format libraries"
SRC_URI="http://savannah.nongnu.org/download/openexr/${MY_P}.tar.gz"
HOMEPAGE="http://www.openexr.com"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~hppa"
IUSE="doc examples"

RDEPEND="virtual/opengl"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	sed -i -e "s:OpenEXR-@OPENEXR_VERSION@:\$\(P\):" ${S}/IlmImfExamples/Makefile.in
	sed -i -e "s:NVSDK_CXXFLAGS=\"\":NVSDK_CXXFLAGS=\"-DUNIX\":" ${S}/acinclude.m4

	epatch ${FILESDIR}/openexr-1.2.2-gcc4.patch
}

src_compile() {
	econf \
		$(use_enable examples imfexamples) \
		--without-fltk-config

	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS Changelog README* ChangeLog LICENSE NEWS
	if use examples && [ "${P}" != "${PF}" ] ; then
		mv ${D}/usr/share/doc/${P}/examples ${D}/usr/share/doc/${PF}/examples
	fi
	use doc && dohtml -r ${S}/doc/*
}

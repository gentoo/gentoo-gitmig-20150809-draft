# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-1.2.2.ebuild,v 1.1 2005/03/18 20:02:12 chriswhite Exp $

MY_P=OpenEXR-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ILM's HDR image file format libraries"
SRC_URI="http://savannah.nongnu.org/download/openexr/${MY_P}.tar.gz"
HOMEPAGE="http://www.openexr.com"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="doc"

DEPEND="x11-libs/fltk"

src_unpack() {
	unpack ${A}
	sed -i -e "s:OpenEXR-@OPENEXR_VERSION@:\$\(P\):" ${S}/IlmImfExamples/Makefile.in
	sed -i -e "s:NVSDK_CXXFLAGS=\"\":NVSDK_CXXFLAGS=\"-DUNIX\":" ${S}/acinclude.m4
}

src_compile() {
	local myconf="--disable-fltktest"
	use doc && myconf="${myconf} --enable-imfexamples"
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "install failed"

	dodoc AUTHORS README INSTALL ChangeLog LICENSE NEWS
	use doc && dohtml -r ${S}/doc/*
}

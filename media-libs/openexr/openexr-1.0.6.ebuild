# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-1.0.6.ebuild,v 1.2 2004/03/19 07:56:04 mr_bones_ Exp $

MY_P=OpenEXR-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ILM's HDR image file format libraries"
SRC_URI="http://savannah.nongnu.org/download/openexr/OpenEXR.pkg/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://www.openexr.com"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND="x11-libs/fltk"

src_unpack() {

	unpack ${A}

	# Lets NVSDK test work correctly & html docs install to the correct directory
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {

	./configure --disable-fltktest \
		--enable-imfexamples \
		--prefix=/usr \
		--sysconfdir=/etc || die "configure failed"

	emake || die "make failed"

}

src_install () {

	einstall || die "install failed"

	dodoc AUTHORS README INSTALL ChangeLog LICENSE NEWS
	dohtml -r ${S}/doc/*
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/k3d/k3d-0.5.0.33.ebuild,v 1.3 2005/11/03 10:45:12 lu_zero Exp $

inherit eutils

DESCRIPTION="a free 3D modeling, animation, and rendering system"
HOMEPAGE="http://k3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/k3d/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="expat gnome imagemagick jpeg nls openexr plib png python qt tiff truetype xml2"

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	dev-libs/boost
	expat? ( dev-libs/expat )
	xml2? ( dev-libs/libxml2 )
	!xml2? ( dev-libs/expat )
	truetype? ( >=media-libs/freetype-2 )
	gnome? ( gnome-base/libgnome )
	imagemagick? ( media-gfx/imagemagick )
	jpeg? ( media-libs/jpeg )
	dev-cpp/glibmm dev-cpp/gtkmm x11-libs/gtkglext
	openexr? ( media-libs/openexr )
	plib? ( media-libs/plib )
	png? ( media-libs/libpng )
	python? ( >=dev-lang/python-2.3 )
	qt? ( x11-libs/qt )
	tiff? ( media-libs/tiff )
	=dev-libs/libsigc++-2.0*"
src_unpack() {
	unpack ${A}
	sed -i -e "s:#if _LIB_VERSION == _IEEE_:#if 0:" \
		${S}/modules/javascript/js/src/fdlibm/k_standard.c \
		|| die "errno fix failed"
	rm -f ${S}/modules/javascript/object_model.cpp
	touch ${S}/modules/javascript/object_model.cpp
}

src_compile() {
	local myconf="--with-ngui"
	if use expat || ! use xml2 ; then
		myconf="--without-libxml2"
	else
		myconf="--with-libxml2"
	fi

	econf \
		$(use_enable nls) \
		--with-external-boost \
		$(use_with truetype freetype2) \
		$(use_with gnome) \
		$(use_with graphviz) \
		$(use_with imagemagick) \
		$(use_with javascript) \
		$(use_with jpeg) \
		$(use_with openexr) \
		$(use_with plib) \
		$(use_with png) \
		$(use_with python) \
		$(use_with qt) \
		$(use_with svg svg-icons) \
		$(use_with tiff) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS INSTALL NEWS README TODO
	#missing dir
	dodir /usr/share/k3d/shaders/layered
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/k3d/k3d-0.6.7.0-r1.ebuild,v 1.2 2009/01/27 02:41:11 gengor Exp $

inherit flag-o-matic

DESCRIPTION="A free 3D modeling, animation, and rendering system"
HOMEPAGE="http://www.k-3d.org/"
SRC_URI="mirror://sourceforge/k3d/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="expat gnome graphviz imagemagick jpeg nls openexr plib png python svg tiff truetype xml"

RDEPEND="virtual/opengl
	virtual/glu
	dev-libs/boost
	expat? ( dev-libs/expat )
	xml? ( dev-libs/libxml2 )
	!xml? ( dev-libs/expat )
	truetype? ( >=media-libs/freetype-2 )
	gnome? ( gnome-base/libgnome )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( media-gfx/imagemagick )
	jpeg? ( media-libs/jpeg )
	>=dev-cpp/glibmm-2.6
	>=dev-cpp/gtkmm-2.6
	>=x11-libs/gtkglext-1.0.6-r3
	openexr? ( media-libs/openexr )
	plib? ( media-libs/plib )
	png? ( media-libs/libpng )
	python? ( >=dev-lang/python-2.3 )
	tiff? ( media-libs/tiff )
	>=dev-libs/libsigc++-2.2
	gnome-base/librsvg
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libICE
	x11-libs/libSM
	media-libs/mesa"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-sigc2.patch
}

src_compile() {
	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	local myconf="--with-ngui"
	if use expat || ! use xml ; then
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
		$(use_with jpeg) \
		$(use_with openexr) \
		$(use_with plib) \
		$(use_with png) \
		$(use_with python) \
		$(use_with svg svg-icons) \
		$(use_with tiff) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README TODO
	#missing dir
	dodir /usr/share/k3d/shaders/layered
	keepdir /usr/share/k3d/shaders/layered
}

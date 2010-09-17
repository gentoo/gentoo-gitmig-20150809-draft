# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace/crystalspace-1.2.1.ebuild,v 1.5 2010/09/17 10:56:51 scarabeus Exp $

EAPI=2
inherit eutils flag-o-matic multilib wxwidgets

MY_P=${PN}-src-${PV}
DESCRIPTION="Portable 3D Game Development Kit written in C++"
HOMEPAGE="http://crystal.sourceforge.net/"
SRC_URI="mirror://sourceforge/crystal/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="3ds alsa cal3d cegui cg doc javascript jpeg mng ode png python
sdl truetype vorbis wxwidgets"

RDEPEND="virtual/opengl
	cg? ( media-gfx/nvidia-cg-toolkit )
	ode? ( dev-games/ode )
	cal3d? ( >=media-libs/cal3d-0.11 )
	jpeg? ( media-libs/jpeg )
	sdl? ( media-libs/libsdl )
	vorbis? ( media-libs/libogg
		media-libs/libvorbis )
	truetype? ( >=media-libs/freetype-2.1 )
	alsa? ( media-libs/alsa-lib )
	mng? ( media-libs/libmng )
	png? ( media-libs/libpng )
	wxwidgets? ( x11-libs/pango
		=x11-libs/wxGTK-2.6* )
	javascript? ( dev-lang/spidermonkey )
	cegui? ( >=dev-games/cegui-0.5.0 )
	x11-libs/libXaw
	x11-libs/libXxf86vm"
DEPEND="${RDEPEND}
	3ds? ( media-libs/lib3ds )
	dev-util/ftjam
	dev-lang/swig
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Installing doc conflict with dodoc on src_install
	# Removing conflicting target
	sed -i \
		-e "/^InstallDoc/d" \
		Jamfile.in \
		docs/Jamfile \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-libpng14.patch
}

src_configure() {
	if useq wxwidgets; then
		WX_GTK_VER=2.6
		need-wxwidgets gtk2
	fi

	# -O3 is hanging compilation of python script plugin
	# trying -O2 just in case
	replace-flags -O3 -O2
	econf --enable-cpu-specific-optimizations=no \
		--disable-separate-debug-info \
		--without-lcms \
		--without-caca \
		--without-bullet \
		--without-openal \
		--without-jackasyn \
		--without-mikmod \
		--without-perl \
		--without-java \
		--disable-make-emulation \
		$(use_with python) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with mng) \
		$(use_with vorbis) \
		$(use_with 3ds) \
		$(use_with ode) \
		$(use_with truetype freetype2) \
		$(use_with cal3d) \
		$(use_with sdl) \
		$(use_with wxwidgets wx) \
		$(use_with cegui CEGUI) \
		$(use_with cg Cg) \
		$(use_with javascript js) \
		$(use_with alsa asound)
	#remove unwanted CFLAGS added by ./configure
	sed -i -e '/COMPILER\.CFLAGS\.optimize/d' \
		Jamconfig \
		|| die "sed failed"
}

src_compile() {
	jam -q || die "compile failed"
}

src_install() {
	for installTarget in install_bin install_plugin install_lib \
		install_include install_data install_config
	do
		jam -q -s DESTDIR="${D}" ${installTarget} \
			|| die "jam ${installTarget} failed"
	done
	if use doc; then
		jam -q -s DESTDIR="${D}" install_doc || die "jam install_doc failed"
	fi
	dodoc README docs/history* docs/todo_*

	echo "CRYSTAL_PLUGIN=/usr/$(get_libdir)/${P}" > 90crystalspace
	echo "CRYSTAL_CONFIG=/etc/${P}" >> 90crystalspace
	doenvd 90crystalspace
}

pkg_postinst() {
	elog "Examples coming with this package, need correct light calculation"
	elog "Do the following commands, with the root account, to fix that:"
	# Fill cache directory for the examples
	local dir
	for dir in castle flarge isomap parallaxtest partsys r3dtest stenciltest \
		terrain terrainf;
	do
		elog "cslight -video=null /usr/share/${PN}/data/maps/${dir}"
	done
}

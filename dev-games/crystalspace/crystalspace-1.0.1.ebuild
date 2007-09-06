# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace/crystalspace-1.0.1.ebuild,v 1.4 2007/09/06 07:29:38 opfer Exp $

inherit flag-o-matic java-pkg-opt-2 multilib wxwidgets

MY_P=${PN}-src-${PV}
DESCRIPTION="Portable 3D Game Development Kit written in C++"
HOMEPAGE="http://crystal.sourceforge.net/"
SRC_URI="mirror://sourceforge/crystal/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="3ds alsa cal3d cegui cg doc java javascript jpeg mng ode perl png python
sdl truetype vorbis wxwindows"

RDEPEND="virtual/opengl
	virtual/glu
	java? ( >=virtual/jre-1.5 )
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
	wxwindows? ( x11-libs/pango
		=x11-libs/wxGTK-2.6* )
	javascript? ( dev-lang/spidermonkey )
	cegui? ( >=dev-games/cegui-0.5.0 )
	x11-libs/libXaw
	x11-libs/libXxf86vm"
DEPEND="${RDEPEND}
	3ds? ( media-libs/lib3ds )
	java? ( dev-java/ant-core
		>=virtual/jdk-1.5 )
	dev-util/jam
	dev-lang/swig
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Installing doc conflict with dodoc on src_install
	# Removing conflicting target
	sed -i -e "/^InstallDoc/d" \
		Jamfile.in \
		docs/Jamfile \
		|| die "sed failed"
}

src_compile() {
	if useq wxwindows; then
		WX_GTK_VER=2.6
		need-wxwidgets gtk2
		if [[ ! -e /usr/bin/wx-config ]]; then
			sed -i -e "s:wx-config:${WX_CONFIG_NAME}:g" configure
		fi
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
		--disable-make-emulation \
		$(use_with perl) \
		$(use_with python) \
		$(use_with java) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with mng) \
		$(use_with vorbis) \
		$(use_with 3ds) \
		$(use_with ode) \
		$(use_with truetype freetype2) \
		$(use_with cal3d) \
		$(use_with sdl) \
		$(use_with wxwindows wx) \
		$(use_with cegui CEGUI) \
		$(use_with cg Cg) \
		$(use_with javascript js) \
		$(use_with alsa asound)
	#remove unwanted CFLAGS added by ./configure
	sed -i -e '/COMPILER\.CFLAGS\.optimize/d' \
		Jamconfig \
		|| die "sed failed"
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

	echo "CRYSTAL_PLUGIN=/usr/$(get_libdir)/crystalspace" > 90crystalspace
	echo "CRYSTAL_CONFIG=/etc/crystalspace" >> 90crystalspace
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

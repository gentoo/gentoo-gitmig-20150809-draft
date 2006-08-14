# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.7.1_p20060704.ebuild,v 1.4 2006/08/14 15:28:19 genstef Exp $

inherit nsplugins kde-functions autotools

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.bz2"
S=${WORKDIR}/${PN}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE="mad nsplugin nptl xml kde video_cards_i810"

RDEPEND="
	xml? ( dev-libs/libxml2 )
	kde? (
		kde-base/kdelibs
		x11-libs/qt
	)
	sys-libs/zlib
	media-libs/jpeg
	mad? ( media-libs/libmad )
	media-libs/libogg
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer
	net-misc/curl
	virtual/opengl
	|| (
		( x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXt
		x11-proto/xproto )
		virtual/x11
	)
	dev-libs/atk
	dev-libs/glib
	x11-libs/cairo
	>x11-libs/gtk+-2
	x11-libs/gtkglext
	x11-libs/pango"

set-kdedir

src_unpack() {
	unpack ${A}
	cd ${S}

	# as-needed patch
	# http://savannah.gnu.org/bugs/?func=detailitem&item_id=16684
	epatch ${FILESDIR}/${P}-opengl.diff
	# CXXFLAGS should be ussed for cpp code and libtool for installation
	# http://savannah.gnu.org/bugs/?func=detailitem&item_id=17049
	epatch ${FILESDIR}/gnash-fix-cxxflags-rpath.patch


	# we want sound
	sed -i -e "s:bool do_sound = .*:bool do_sound = true;:" backend/gnash.cpp

	AT_M4DIR="macros" eautoreconf
}

src_compile() {
	local myconf

	use nsplugin && myconf="${myconf}  --enable-plugin --with-plugindir=/opt/netscape/plugins"

	#--enable-renderer=engine Specify rendering engine:
	#				OpenGL (default)
	#				Cairo  (experimental)
	#cairo: does not compile, offers flash for non-accelerated gfx?
	#if use cairo; then
	#	myconf="${myconf}  --enable-renderer=cairo"
	#fi
	#--enable-gui=flavor Specify gui flavor:
	#				GTK
	#				SDL -> has no controls, we do not USE it
	#$(use_enable gtk glext) with USE=-gtk, fails to detect gtkglext, bug 135010

	econf \
		$(use_enable kde klash) \
		$(use_enable mad mp3) \
		$(use_enable nptl pthreads) \
		$(use_enable xml) \
		$(use_enable video_cards_i810 i810-lod-bias) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so \
		|| rm -rf ${D}/opt
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}

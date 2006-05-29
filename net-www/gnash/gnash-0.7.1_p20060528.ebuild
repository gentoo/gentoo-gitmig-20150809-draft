# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.7.1_p20060528.ebuild,v 1.2 2006/05/29 00:54:50 genstef Exp $

inherit nsplugins kde-functions autotools

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE="dmalloc mad nsplugin nptl xml kde gtk video_cards_i810"

RDEPEND="dmalloc? ( dev-libs/dmalloc )
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
	virtual/opengl
	|| (
		( x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXt
		x11-proto/xproto )
		virtual/x11
	)
	gtk? (
		dev-libs/atk
		dev-libs/glib
		x11-libs/cairo
		>x11-libs/gtk+-2
		x11-libs/gtkglext
		x11-libs/pango
	)"

S=${WORKDIR}/gnash

set-kdedir

src_unpack() {
	unpack ${A}

	#Fix a busted opengl as-needed
	cd ${S}
	epatch ${FILESDIR}/${P}-opengl.diff
	epatch ${FILESDIR}/${P}-confcache-gtkglext.patch

	# we want sound
	sed -i -e "s:bool do_sound = .*:bool do_sound = true;:" backend/gnash.cpp

	AT_M4DIR="macros" eautoreconf
}

src_compile() {
	local myconf

	if use nsplugin; then
		myconf="${myconf}  --enable-plugin --with-plugindir=/opt/netscape/plugins"
	fi

	econf \
		$(use_enable dmalloc) \
		$(use_enable kde klash) \
		$(use_enable mad mp3) \
		$(use_enable nptl pthreads) \
		$(use_enable xml) \
		$(use_enable gtk glext) \
		$(use_enable video_cards_i810 i810-lod-bias) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	sed -i -e "s:-lXmu @inst_prefix_dir:-lXmu -L../backend/.libs -L../server/.libs -L../libgeometry/.libs -L../libbase/.libs -L. @inst_prefix_dir:" server/libgnashserver.la
	make DESTDIR=${D} install || die "make install failed"
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so \
		|| rm ${D}/opt/netscape/plugins/libgnashplugin.so
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}

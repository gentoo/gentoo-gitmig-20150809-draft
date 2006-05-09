# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.7.1.ebuild,v 1.1 2006/05/09 23:54:55 genstef Exp $

inherit nsplugins kde-functions autotools

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="dmalloc mp3 nsplugin nptl xml kde"

DEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng
	|| (
		( x11-libs/libX11
		x11-libs/libXt
		x11-proto/xproto )
		virtual/x11
	)
	xml? ( dev-libs/libxml2 )
	dmalloc? ( dev-libs/dmalloc )
	mp3? ( media-libs/libmad )
	media-libs/libcaca
	media-libs/libogg
	media-libs/sdl-mixer
	sys-libs/gpm
	sys-libs/ncurses
	sys-libs/slang
	kde? ( kde-base/kdelibs )
		dev-libs/glib
		dev-libs/atk
		x11-libs/pango
		x11-libs/cairo
		>x11-libs/gtk+-2
		x11-libs/gtkglext
	virtual/opengl
	media-libs/libsdl"
RDEPEND="${DEPEND}"
set-kdedir

src_compile() {
	epatch ${FILESDIR}/gnash-as-needed.diff
	AT_M4DIR="macros" eautoreconf
	econf \
		$(use_enable dmalloc) \
		$(use_enable kde klash) \
		$(use_enable mp3) \
		$(use_enable nptl pthreads) \
		$(use_enable xml) \
		--with-plugindir=/opt/netscape/plugins \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
		# fails when disabled
		#$(use_enable nsplugin plugin) \
		#$(use_with nsplugin plugindir /opt/netscape/plugins) \
		#$(use_enable gtk glext) \
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so \
		|| rm ${D}//opt/netscape/plugins/libgnashplugin.so
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}

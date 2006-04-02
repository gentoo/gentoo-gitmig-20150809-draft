# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.7_alpha20060331.ebuild,v 1.1 2006/04/02 15:52:24 genstef Exp $

inherit cvs nsplugins

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI=""
ECVS_SERVER="cvs.sv.gnu.org:/sources/${PN}"
ECVS_MODULE="${PN}"
ECVS_CO_OPTS="-D ${PV/0.7_alpha}"
ECVS_UP_OPTS="-dP ${ECVS_CO_OPTS}"
S=${WORKDIR}/${ECVS_MODULE}

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
	media-libs/sdl-mixer
	sys-libs/gpm
	sys-libs/ncurses
	sys-libs/slang
		virtual/opengl
		media-libs/libsdl
	kde? ( kde-base/kdelibs )"
#	plugin? ( 
#		!sdl? (
#			dev-libs/glib
#			dev-libs/atk
#			x11-libs/pango
#			x11-libs/cairo
#			>x11-libs/gtk+-2
#			x11-libs/gtkglext
#		)
#		sdl? (
RDEPEND="${DEPEND}"

src_compile() {
	libtoolize --copy --force || die "libtoolize --copy --force failed"
	./autogen.sh || die "autogen.sh failed"
	econf \
		$(use_enable nptl pthreads) \
		$(use_enable mp3) \
		$(use_enable xml) \
		$(use_enable kde klash) \
		$(use_enable dmalloc) \
		$(use_enable nsplugin plugin) \
		--with-plugindir=/opt/netscape/plugins \
		|| die "econf failed"
		#$(use_enable !sdl glext) \
	# ugly workaround
	sed -i 's:exit $EXIT_FAILURE:#exit $EXIT_FAILURE:' libtool || die "failed"

	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}

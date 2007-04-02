# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.19.1.ebuild,v 1.1 2007/04/02 23:22:25 hanno Exp $

inherit nsplugins eutils perl-module toolchain-funcs

IUSE="nsplugin"

DESCRIPTION="VRML2 and X3D compliant browser"
SRC_URI="mirror://sourceforge/freewrl/${P}.tar.gz"
HOMEPAGE="http://freewrl.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="|| ( (
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXxf86vm
		x11-libs/libXext
		x11-libs/libX11
		media-libs/mesa
	) virtual/x11 )
	virtual/opengl
	virtual/jdk
	media-libs/libpng
	media-libs/jpeg
	>=media-libs/freetype-2
	>=dev-lang/perl-5.8.2
	dev-perl/XML-Parser
	media-fonts/ttf-bitstream-vera
	!<media-gfx/freewrl-1.18.10"
RDEPEND="media-gfx/imagemagick
	media-sound/sox
	net-misc/wget
	${DEPEND}"
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use nsplugin; then
		sed -i -e "s:/usr/lib/mozilla/plugins:/usr/$(get_libdir)/${PLUGINS_DIR}:g" vrml.conf
	else
		sed -i -e "s:NETSCAPE_:#NETSCAPE_:g" vrml.conf
	fi

	sed -i -e 's:-DHAVE_MOTIF::g' vrml.conf
}

src_compile() {
	perl Makefile.PL
	emake || die "make failed"

	if use nsplugin; then
		cd ${S}/Plugin
		# build plugin with -fPIC
		emake OPTIMIZER="$CFLAGS -DPIC -fPIC" || die "make failed"
	fi
}

src_install() {
	if use nsplugin; then
		# create plugins dir *before* emake install, so that plugin will get installed
		insinto /usr/$(get_libdir)/${PLUGINS_DIR}
		doins java/classes/vrml.jar
	fi
	emake DESTDIR=${D} install || die "make install failed"
	rm -rf ${D}/usr/share/freewrl/fonts
	dosym /usr/share/fonts/ttf-bitstream-vera /usr/share/freewrl/fonts
}

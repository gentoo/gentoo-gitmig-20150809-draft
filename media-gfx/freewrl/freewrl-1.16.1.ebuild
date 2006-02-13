# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.16.1.ebuild,v 1.4 2006/02/13 14:49:12 mcummings Exp $

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
	dev-perl/XML-Parser"
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

	epatch "${FILESDIR}/freewrl-1.16.1-plugin-install.patch"
	epatch "${FILESDIR}/freewrl-1.16.1-use-java-home.patch"
	epatch "${FILESDIR}/freewrl-1.16.1-disable-rpm.patch"
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
}

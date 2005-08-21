# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/kdrive/kdrive-6.6.1_pre20050820.ebuild,v 1.3 2005/08/21 07:25:00 spyderous Exp $

SNAPSHOT="yes"

inherit flag-o-matic x-modular

PATCHES="${FILESDIR}/make-xv-configable.patch"

MY_PN="xserver"
MY_P="${MY_PN}-${PV##*pre}"
SRC_URI="http://dev.gentoo.org/~spyderous/overlay/distfiles/${MY_P}.tar.bz2"
HOMEPAGE="http://xserver.freedesktop.org/wiki/Software/Xserver"
DESCRIPTION="Experimental X11 implementations"
KEYWORDS="~x86"
IUSE="ipv6 static minimal"
RDEPEND="x11-libs/libXdmcp
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfont
	x11-libs/xtrans
	x11-libs/libXau
	x11-libs/libXrender
	>=media-libs/glitz-0.4.3
	media-libs/freetype"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/fixesproto
	x11-proto/damageproto
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/compositeproto
	x11-proto/resourceproto
	x11-proto/recordproto"

# Strip off the version
S="${WORKDIR}/${MY_P%%-[0-9]*}"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable ipv6)
		$(use_enable !minimal xv)
		$(use_enable !minimal composite)
		$(use_enable !minimal xrecord)
		$(use_enable !minimal xres)
		--enable-xglserver
		--enable-xglxserver
		--disable-xeglserver
		--with-fontpath=/usr/share/fonts/misc,/usr/share/fonts/100dpi,/usr/share/fonts/75dpi"
	# Probably need to --enable-egl in glitz for this
	#	--enable-xeglserver

	append-ldflags -Wl,-z,now
}

src_compile() {
	x-modular_src_configure

	# Has to be after configure, or configure dies
	if use static; then
		append-ldflags -all-static
	fi

	# Yes, we do need the LDFLAGS here in addition to the above append.
	emake LDFLAGS="${LDFLAGS}"
}

src_install() {
	x-modular_src_install

	ebegin "Making X servers suid"
		find ${D}${XDIR}/bin -name 'X*' \
			| sed -e "s:${D}::g" \
			| xargs fperms u+s
	eend 0

	# Install our startx script
	exeinto ${XDIR}/bin
	doexe ${FILESDIR}/startxkd
}

pkg_postinst() {
	x-modular_pkg_postinst

	einfo "You may edit ${XDIR}/bin/startxkd to your preferences."
	einfo "Xvesa is the default."
	einfo "Or you can use something like:"
	einfo "\"xinit -- ${XDIR}/bin/Xvesa :0 -screen 1280x1024x16 -nolisten tcp\"."
	einfo "Your ~/.xinitrc will be used if you use xinit."
}

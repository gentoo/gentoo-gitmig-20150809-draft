# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-4.1.2.ebuild,v 1.4 2006/08/29 10:54:26 blubb Exp $

inherit eutils toolchain-funcs multilib autotools

XSERVER_VERSION="1.1.1"

MY_P="vnc-4_1_2-unixsrc"
DESCRIPTION="Remote desktop viewer display system"
HOMEPAGE="http://www.realvnc.com/"
SRC_URI="http://ltsp.mirrors.tds.net/pub/ltsp/tarballs/${MY_P}.tar.gz
	http://ftp.plusline.de/FreeBSD/distfiles/xc/${MY_P}.tar.gz
	http://www.gentooexperimental.org/~genstef/dist/${P}-patches.tar.bz2
	server? ( ftp://ftp.freedesktop.org/pub/xorg/individual/xserver/xorg-server-${XSERVER_VERSION}.tar.bz2	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE="server"

RDEPEND="sys-libs/zlib
	media-libs/freetype
	|| ( ( x11-libs/libSM
			x11-libs/libXtst
		)
		virtual/x11
	)
	server? ( || ( ( x11-libs/libXi
			x11-libs/libXfont
			x11-libs/libXmu
			x11-libs/libxkbfile
			x11-libs/libXrender
			x11-apps/xauth
			x11-apps/xsetroot
			x11-proto/compositeproto
			x11-proto/damageproto
			x11-proto/fixesproto
			x11-proto/fontsproto
			x11-proto/randrproto
			x11-proto/resourceproto
			x11-proto/scrnsaverproto
			x11-proto/trapproto
			x11-proto/videoproto
			x11-proto/xineramaproto
			x11-proto/xf86bigfontproto
			x11-proto/xf86dgaproto
			x11-proto/xf86miscproto
			x11-proto/xf86vidmodeproto
			media-fonts/font-adobe-100dpi
			media-fonts/font-adobe-75dpi
			media-fonts/font-alias
			media-fonts/font-cursor-misc
			media-fonts/font-misc-misc
			)
			virtual/x11
		)
	)
	!net-misc/tightvnc"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
		)
		virtual/x11
	)"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	
	cd ${S}

	# patches from Fedora
	epatch ${WORKDIR}/${P}/vnc-viewer-reparent.patch
	epatch ${WORKDIR}/${P}/vnc-newfbsize.patch

	if use server; then
		mv ${WORKDIR}/xorg-server-${XSERVER_VERSION} unix/

		# patches from Fedora
		epatch ${WORKDIR}/${P}/vnc-cookie.patch
		epatch ${WORKDIR}/${P}/vnc-gcc4.patch
		epatch ${WORKDIR}/${P}/vnc-use-fb.patch
		epatch ${WORKDIR}/${P}/vnc-xclients.patch
		epatch ${WORKDIR}/${P}/vnc-idle.patch
		epatch ${WORKDIR}/${P}/vnc-via.patch
		epatch ${WORKDIR}/${P}/vnc-build.patch
		epatch ${WORKDIR}/${P}/vnc-fPIC.patch
		epatch ${WORKDIR}/${P}/vnc-restart.patch
		epatch ${WORKDIR}/${P}/vnc-vncpasswd.patch
		epatch ${WORKDIR}/${P}/vnc-def.patch
		epatch ${WORKDIR}/${P}/vnc-modular-xorg.patch
		epatch ${WORKDIR}/${P}/vnc-nohttpd.patch

		cd unix/xorg-server-*
		epatch ${WORKDIR}/${P}/vnc-fontpath.patch
		epatch ${WORKDIR}/${P}/vnc-s390.patch

		cd ../../

		epatch ${WORKDIR}/${P}/vnc-64bit.patch
		epatch ${WORKDIR}/${P}/vnc-select.patch
		epatch ${WORKDIR}/${P}/vnc-opengl.patch

		cp -a ${S}/unix/xc/programs/Xserver/vnc/Xvnc/xvnc.cc \
			${S}/unix/xc/programs/Xserver/Xvnc.man \
			${S}/unix/xc/programs/Xserver/vnc/*.{h,cc} \
			${S}/unix/xorg-server-*/hw/vnc
		cp -a ${S}/unix/xorg-server-*/{cfb/cfb.h,hw/vnc}
		cp -a ${S}/unix/xorg-server-*/{fb/fb.h,hw/vnc}
		cp -a ${S}/unix/xorg-server-*/{fb/fbrop.h,hw/vnc}
		sed -i -e 's,xor,c_xor,' -e 's,and,c_and,' \
			${S}/unix/xorg-server*/hw/vnc/{cfb,fb,fbrop}.h
	fi
}

src_compile() {
	cd unix
	eautoreconf
	econf --with-installed-zlib --with-fb || die "econf failed"
	emake || die "emake failed"

	if use server; then
		cd xorg-server-*
		eautoreconf
		econf \
			--enable-xorg \
			--disable-dependency-tracking \
			--disable-xprint \
			--disable-static \
			--enable-composite \
			--with-xkb-output=/usr/share/X11/xkb \
			--with-rgb-path=/usr/share/X11/rgb.txt \
			--disable-xorgcfg \
			--disable-dmx \
			--disable-lbx \
			--enable-xdmcp \
			--disable-xevie \
			--disable-dri \
			--with-int10=stub \
			--with-default-font-path=/usr/share/fonts/misc,/usr/share/fonts/75dpi,/usr/share/fonts/100dpi,/usr/share/fonts/TTF,/usr/share/fonts/Type1 \
			|| die "econf server failed"
		emake CDEBUGFLAGS="${CFLAGS}" CXXDEBUGFLAGS="${CXXFLAGS}" || die "emake server failed"
	fi
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	use server && dodir /usr/$(get_libdir)/modules/extensions

	cd unix
	./vncinstall ${D}/usr/bin ${D}/usr/share/man ${D}/usr/$(get_libdir)/modules/extensions || die
	cd ..
	dodoc README

	use server || (
		rm ${D}/usr/bin/vncserver
		rm ${D}/usr/bin/x0vncserver
		rm ${D}/usr/share/man/man1/vnc{passwd,config,server}.1
		rm ${D}/usr/share/man/man1/x0vncserver.1
		rm ${D}/usr/bin/vncpasswd
		rm ${D}/usr/bin/vncconfig
	)

	ewarn "Note that the free VNC release is not designed for use on untrusted networks"
}

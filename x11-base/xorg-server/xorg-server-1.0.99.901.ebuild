# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-server/xorg-server-1.0.99.901.ebuild,v 1.1 2006/04/14 16:04:12 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
# Hack to make sure autoreconf gets run
#SNAPSHOT="yes"

inherit flag-o-matic x-modular multilib

OPENGL_DIR="xorg-x11"

MESA_PN="Mesa"
MESA_PV="6.5"
MESA_P="${MESA_PN}-${MESA_PV}"
MESA_SRC_P="${MESA_PN}Lib-${MESA_PV}"

PATCHES="${FILESDIR}/${PN}-1.0.2-Sbus.patch
	${FILESDIR}/1.0.2-try-to-fix-xorgcfg.patch
	${FILESDIR}/1.0.2-fix-xorgconfig-rgbpath-and-mouse.patch"

SRC_URI="${SRC_URI}
	mirror://sourceforge/mesa3d/${MESA_SRC_P}.tar.bz2
	http://xorg.freedesktop.org/snapshots/individual/xserver/${P}.tar.bz2"
DESCRIPTION="X.Org X servers"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="dri ipv6 minimal xprint"
RDEPEND="x11-libs/libXfont
	x11-libs/xtrans
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libxkbfile
	x11-libs/libXdmcp
	x11-libs/libXmu
	x11-libs/libXrender
	x11-libs/libXi
	media-libs/freetype
	>=media-libs/mesa-6.5-r2
	media-fonts/font-adobe-75dpi
	media-fonts/font-misc-misc
	media-fonts/font-cursor-misc
	x11-misc/xbitmaps
	|| ( x11-misc/xkeyboard-config x11-misc/xkbdata )
	x11-apps/iceauth
	x11-apps/rgb
	x11-apps/xauth
	x11-apps/xinit
	app-admin/eselect-opengl
	x11-libs/libXaw
	x11-libs/libXpm
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm
	!minimal? ( x11-libs/libdmx
		x11-libs/libXtst
		x11-libs/libXres )
	x11-libs/libxkbui
	x11-libs/liblbxutil"
	# Xres is dmx-dependent, xkbui is xorgcfg-dependent
	# Xaw is dmx- and xorgcfg-dependent
	# Xpm is dmx- and xorgcfg-dependent, pulls in Xt
	# Xxf86misc and Xxf86vm are xorgcfg-dependent
	# liblbxutil is lbx- dependent
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/renderproto
	>=x11-proto/fixesproto-4
	x11-proto/damageproto
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/xf86dgaproto
	x11-proto/xf86miscproto
	x11-proto/xf86rushproto
	x11-proto/xf86vidmodeproto
	x11-proto/xf86bigfontproto
	>=x11-proto/compositeproto-0.3
	x11-proto/recordproto
	x11-proto/resourceproto
	x11-proto/videoproto
	x11-proto/scrnsaverproto
	x11-proto/evieext
	x11-proto/trapproto
	>=x11-proto/xineramaproto-1.1-r1
	x11-proto/fontsproto
	>=x11-proto/kbproto-1.0-r1
	x11-proto/inputproto
	x11-proto/bigreqsproto
	x11-proto/xcmiscproto
	>=x11-proto/glproto-1.4.1_pre20051013
	!minimal? ( x11-proto/dmxproto )
	dri? ( x11-proto/xf86driproto
		>=x11-libs/libdrm-2 )
	xprint? ( x11-proto/printproto
		x11-apps/mkfontdir
		x11-apps/mkfontscale )"
LICENSE="${LICENSE} MIT"

pkg_setup() {
	# localstatedir is used for the log location; we need to override the default
	# from ebuild.sh
	# sysconfdir is used for the xorg.conf location; same applies

	# --enable-xorg needed because darwin defaults off
	# --enable-install-setuid needed because sparcs default off
	CONFIGURE_OPTIONS="
		$(use_enable ipv6)
		$(use_enable !minimal dmx)
		$(use_enable !minimal xvfb)
		$(use_enable !minimal xnest)
		$(use_enable dri)
		$(use_enable xprint)
		--with-mesa-source=${WORKDIR}/${MESA_P}
		--enable-xorg
		--enable-aiglx
		--sysconfdir=/etc/X11
		--localstatedir=/var
		--enable-install-setuid
		--with-default-font-path=/usr/share/fonts/misc,/usr/share/fonts/75dpi,/usr/share/fonts/100dpi,/usr/share/fonts/TTF,/usr/share/fonts/Type1"

	# (#121394) Causes window corruption
	filter-flags -fweb
}

src_install() {
	x-modular_src_install

	dynamic_libgl_install

	use xprint && xprint_src_install
}

pkg_postinst() {
	switch_opengl_implem
}

pkg_postrm() {
	# Get rid of module dir to ensure opengl-update works properly
	if ! has_version x11-base/xorg-server; then
		if [ -e ${ROOT}/usr/$(get_libdir)/xorg/modules ]; then
			rm -rf ${ROOT}/usr/$(get_libdir)/xorg/modules
		fi
	fi
}

dynamic_libgl_install() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving GL files for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${OPENGL_DIR}/extensions
		local x=""
		for x in ${D}/usr/$(get_libdir)/xorg/modules/extensions/libglx*; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${OPENGL_DIR}/extensions
			fi
		done
	eend 0
}

switch_opengl_implem() {
		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
		eselect opengl set --use-old ${OPENGL_DIR}
}

xprint_src_install() {
	# RH-style init script, we provide a wrapper
	exeinto /usr/$(get_libdir)/misc
	# Actually a shell script, someone messed up
	newexe ${S}/Xprint/etc/init.d/xprint.cpp xprint
	sed -e 's/XCOMM/#/' -i ${D}/usr/$(get_libdir)/misc/xprint
	# Install the wrapper
	newinitd ${FILESDIR}/xprint.init xprint
	# Install profile scripts
	insinto /etc/profile.d
	doins ${S}/Xprint/etc/profile.d/xprint*
	insinto /etc/X11/xinit/xinitrc.d
	newins ${S}/Xprint/etc/Xsession.d/cde_xsessiond_xprint.sh \
		92xprint-xpserverlist.sh
	# Patch profile scripts
	sed -e "s:/bin/sh.*get_xpserverlist:/usr/$(get_libdir)/misc/xprint \
		get_xpserverlist:g" -i ${D}/etc/profile.d/xprint* \
		${D}/etc/X11/xinit/xinitrc.d/92xprint-xpserverlist.sh
	# Move profile scripts, we can't touch /etc/profile.d/ in Gentoo
	dodoc ${D}/etc/profile.d/xprint*
	rm -f ${D}/etc/profile.d/xprint*
}

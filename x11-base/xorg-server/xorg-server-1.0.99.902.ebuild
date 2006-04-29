# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-server/xorg-server-1.0.99.902.ebuild,v 1.1 2006/04/29 16:38:38 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
# Hack to make sure autoreconf gets run
SNAPSHOT="yes"

inherit x-modular multilib

OPENGL_DIR="xorg-x11"

MESA_PN="Mesa"
MESA_PV="6.5"
MESA_P="${MESA_PN}-${MESA_PV}"
MESA_SRC_P="${MESA_PN}Lib-${MESA_PV}"

PATCHES="${FILESDIR}/${PN}-1.0.2-xprint-init.patch
	${FILESDIR}/1.0.99.901-Xprint-xprintdir.patch"

SRC_URI="${SRC_URI}
	mirror://sourceforge/mesa3d/${MESA_SRC_P}.tar.bz2
	http://xorg.freedesktop.org/snapshots/individual/xserver/${P}.tar.bz2"
DESCRIPTION="X.Org X servers"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE_VIDEO_CARDS="
	video_cards_chips
	video_cards_epson
	video_cards_glint
	video_cards_i810
	video_cards_mach64
	video_cards_mga
	video_cards_neomagic
	video_cards_nv
	video_cards_r128
	video_cards_radeon
	video_cards_siliconmotion
	video_cards_via"
IUSE="${IUSE_VIDEO_CARDS}
	dmx dri ipv6 kdrive minimal nptl sdl xorg xprint"
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
	x11-libs/liblbxutil
	kdrive? ( sdl? ( media-libs/libsdl ) )"
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
	>=x11-proto/scrnsaverproto-1.1.0
	x11-proto/evieext
	x11-proto/trapproto
	>=x11-proto/xineramaproto-1.1-r1
	x11-proto/fontsproto
	>=x11-proto/kbproto-1.0-r1
	x11-proto/inputproto
	x11-proto/bigreqsproto
	x11-proto/xcmiscproto
	>=x11-proto/glproto-1.4.6
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

	# SDL only available in kdrive build
	if use kdrive && use sdl; then
		conf_opts="${conf_opts} --enable-xsdl"
	else
		conf_opts="${conf_opts} --disable-xsdl"
	fi

	# Only Xorg and Xgl support this, and we won't build Xgl
	# until it merges to trunk
	if use xorg; then
		conf_opts="${conf_opts} --with-mesa-source=${WORKDIR}/${MESA_P}"
	fi

	CONFIGURE_OPTIONS="
		$(use_enable ipv6)
		$(use_enable dmx)
		$(use_enable kdrive)
		$(use_enable !minimal xvfb)
		$(use_enable !minimal xnest)
		$(use_enable dri)
		$(use_enable xorg)
		$(use_enable xprint)
		$(use_enable nptl glx-tls)
		--sysconfdir=/etc/X11
		--localstatedir=/var
		--enable-install-setuid
		--with-default-font-path=/usr/share/fonts/misc,/usr/share/fonts/75dpi,/usr/share/fonts/100dpi,/usr/share/fonts/TTF,/usr/share/fonts/Type1
		${conf_opts}"

	if built_with_use media-libs/mesa nptl; then
		local diemsg="You must build xorg-server and mesa with the same nptl USE setting."
		use nptl || die "${diemsg}"
	else
		use nptl && die "${diemsg}"
	fi

	# (#121394) Causes window corruption
	filter-flags -fweb

	# Nothing else provides new enough glxtokens.h
	ewarn "Forcing on xorg-x11 for new enough glxtokens.h..."
	OLD_IMPLEM="$(eselect opengl show)"
	eselect opengl set --impl-headers ${OPENGL_DIR}
}

src_unpack() {
	x-modular_specs_check
	x-modular_dri_check
	x-modular_unpack_source
	x-modular_patch_source

	# Set up kdrive servers to build
	if use kdrive; then
		einfo "Removing unused kdrive drivers ..."
		for card in ${IUSE_VIDEO_CARDS}; do
			real_card=${card#video_cards_}

			# Differences between VIDEO_CARDS name and kdrive server name
			real_card=${real_card/glint/pm2}
			real_card=${real_card/radeon/ati}
			real_card=${real_card/nv/nvidia}
			real_card=${real_card/siliconmotion/smi}
			if ! use ${card}; then
				ebegin "  ${real_card}"
				sed -i \
					-e "s:${real_card}::g" \
					${S}/hw/kdrive/Makefile.am \
					|| die "sed of ${real_card} failed"
				eend
			fi

		done

		# smi and via are the only things on line 2. If line 2 ends up blank,
		# we need to get rid of the backslash at the end of line 1.
		if ! use video_cards_siliconmotion && ! use video_cards_via; then
			sed -i \
				-e "s:^\(VESA_SUBDIRS.*\)\\\:\1:g" \
				${S}/hw/kdrive/Makefile.am
		fi

		# Only need to reconf if we're modifying kdrive's Makefile.am
		x-modular_reconf_source
	fi
}

src_install() {
	x-modular_src_install

	dynamic_libgl_install

	server_based_install
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

server_based_install() {
	use xprint && xprint_src_install

	if ! use xorg; then
		rm ${D}/usr/share/man/man1/Xserver.1x \
			${D}/usr/$(get_libdir)/xserver/SecurityPolicy \
			${D}/usr/$(get_libdir)/pkgconfig/xorg-server.pc \
			${D}/usr/share/man/man1/Xserver.1x
	fi
}

switch_opengl_implem() {
		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
#		eselect opengl set --use-old ${OPENGL_DIR}
		eselect opengl set ${OLD_IMPLEM}
}

xprint_src_install() {
	# RH-style init script, we provide a wrapper
	exeinto /usr/$(get_libdir)/misc
	doexe ${S}/Xprint/etc/init.d/xprint
	# Patch init script for fonts location
	sed -e 's:/lib/X11/fonts/:/share/fonts/:g' \
		-i ${D}/usr/$(get_libdir)/misc/xprint
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

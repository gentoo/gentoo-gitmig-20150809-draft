# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-server/xorg-server-0.99.1-r5.ebuild,v 1.1 2005/08/22 17:49:11 spyderous Exp $

# Must be before x-modular eclass is inherited
# Hack to make sure autoreconf gets run
SNAPSHOT="yes"

inherit flag-o-matic x-modular

OPENGL_DIR="xorg-x11"

MESA_PN="Mesa"
MESA_PV="6.3.2"
MESA_P="${MESA_PN}-${MESA_PV}"
MESA_SRC_P="${MESA_PN}Lib-${MESA_PV}"

CVS_UPDATE_DATE="20050822"

PATCHES="${WORKDIR}/${P}-update-to-CVS-HEAD-${CVS_UPDATE_DATE}.patch
	${FILESDIR}/fix-xnest.patch"

SRC_URI="${SRC_URI}
	mirror://sourceforge/mesa3d/${MESA_SRC_P}.tar.bz2
	http://dev.gentoo.org/~spyderous/xorg-x11/xorg-server-0.99.1-update-to-CVS-HEAD-${CVS_UPDATE_DATE}.patch.gz"
DESCRIPTION="X.Org X servers"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
#IUSE="dri ipv6 minimal xprint"
IUSE="dri ipv6 minimal"
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
	>=media-libs/mesa-6
	>=x11-base/opengl-update-2.2.3"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/fixesproto
	x11-proto/damageproto
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/xf86dgaproto
	x11-proto/xf86miscproto
	x11-proto/xf86rushproto
	x11-proto/xf86vidmodeproto
	x11-proto/xf86bigfontproto
	x11-proto/compositeproto
	x11-proto/recordproto
	x11-proto/resourceproto
	x11-proto/dmxproto
	x11-proto/videoproto
	x11-proto/scrnsaverproto
	x11-proto/evieext
	x11-proto/trapproto
	>=x11-proto/xineramaproto-1.1-r1
	x11-proto/fontsproto
	x11-proto/kbproto
	x11-proto/inputproto
	x11-proto/bigreqsproto
	x11-proto/xcmiscproto
	x11-proto/glproto
	dri? ( x11-proto/xf86driproto
		x11-libs/libdrm )"
#	xprint? ( x11-proto/printproto )

pkg_setup() {
	# localstatedir is used for the log location; we need to override the default
	# from ebuild.sh
	# sysconfdir is used for the xorg.conf location; same applies
	CONFIGURE_OPTIONS="
		$(use_enable ipv6)
		$(use_enable !minimal dmx)
		$(use_enable !minimal xvfb)
		$(use_enable !minimal xnest)
		$(use_enable dri)
		--disable-xprint
		--with-mesa-source=${WORKDIR}/${MESA_P}
		--enable-xorg
		--enable-xtrap
		--enable-xevie
		--sysconfdir=/etc/X11
		--localstatedir=/var
		--disable-static"
#		$(use_enable xprint)

	# X won't start if -fomit-frame-pointer isn't filtered
	filter-flags -fomit-frame-pointer
}

src_install() {
	x-modular_src_install

	dynamic_libgl_install

	dosym Xorg /usr/bin/X
	fperms 4711 /usr/bin/Xorg
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
		for x in ${D}/usr/$(get_libdir)/xorg/modules/libglx*; do
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
		local opengl_implem="$(${ROOT}/usr/sbin/opengl-update --get-implementation)"
		${ROOT}/usr/sbin/opengl-update --use-old ${OPENGL_DIR}
}

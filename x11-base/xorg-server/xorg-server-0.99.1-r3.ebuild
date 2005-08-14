# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-server/xorg-server-0.99.1-r3.ebuild,v 1.7 2005/08/14 20:51:51 spyderous Exp $

# Must be before x-modular eclass is inherited
# Hack to make sure autoreconf gets run
SNAPSHOT="yes"

inherit x-modular

OPENGL_DIR="xorg-x11"

MESA_PN="Mesa"
MESA_PV="6.3.1.1"
MESA_P="${MESA_PN}-${MESA_PV}"

PATCHES="${WORKDIR}/xorg-server-0.99.1-update-to-CVS-HEAD-20050811-1.patch
	${FILESDIR}/check-for-glproto.patch
	${FILESDIR}/fix-xf86misc-typo.patch
	${FILESDIR}/${P}-x86_64-1.patch"

SRC_URI="${SRC_URI}
	glx? ( http://xorg.freedesktop.org/extras/${MESA_P}.tar.gz )
	http://dev.gentoo.org/~spyderous/xorg-x11/xorg-server-0.99.1-update-to-CVS-HEAD-20050811-1.patch.gz"
DESCRIPTION="X.Org X servers"
KEYWORDS="~sparc ~x86"
IUSE="glx dri ipv6 minimal"
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
	glx? ( >=media-libs/mesa-6
		>=x11-base/opengl-update-2.2.3 )"
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
	x11-proto/panoramixproto
	x11-proto/fontsproto
	x11-proto/kbproto
	x11-proto/inputproto
	x11-proto/bigreqsproto
	x11-proto/xcmiscproto
	glx? ( x11-proto/glproto )
	dri? ( x11-proto/xf86driproto
		x11-libs/libdrm )"

pkg_setup() {
	if use glx; then
		confopts="${confopts} --with-mesa-source=${WORKDIR}/${MESA_P}"
	fi

	# localstatedir is used for the log location; we need to override the default
	# from ebuild.sh
	# sysconfdir is used for the xorg.conf location; same applies
	CONFIGURE_OPTIONS="
		$(use_enable ipv6)
		$(use_enable !minimal dmx)
		$(use_enable !minimal xvfb)
		$(use_enable !minimal xnest)
		$(use_enable glx)
		$(use_enable dri)
		--enable-xorg
		--enable-xtrap
		--enable-xevie
		--sysconfdir=/etc/X11
		--localstatedir=/var
		${confopts}"
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

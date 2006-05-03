# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-2.2.4.ebuild,v 1.9 2006/05/03 08:49:12 eradicator Exp $

inherit multilib

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"

# Source:
# http://oss.sgi.com/projects/ogl-sample/ABI/glext.h
# http://oss.sgi.com/projects/ogl-sample/ABI/glxext.h

GLEXT="29"
GLXEXT="11"

SRC_URI="http://dev.gentoo.org/~eradicator/opengl/glext.h-${GLEXT}.bz2
	 http://dev.gentoo.org/~eradicator/opengl/glxext.h-${GLXEXT}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="mips"
IUSE=""
RESTRICT="multilib-pkg-force"

DEPEND="virtual/libc
	app-arch/bzip2"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	mv glext.h-${GLEXT} glext.h
	mv glxext.h-${GLXEXT} glxext.h
}

pkg_preinst() {
	# It needs to be before 04multilib
	[ -f "${ROOT}/etc/env.d/09opengl" ] && mv ${ROOT}/etc/env.d/09opengl ${ROOT}/etc/env.d/03opengl

	OABI="${ABI}"
	for ABI in $(get_install_abis); do
		if [ -e "${ROOT}/usr/$(get_libdir)/opengl/xorg-x11/lib/libMesaGL.so" ]; then
			einfo "Removing libMesaGL.so from xorg-x11 profile.  See bug #47598."
			rm -f ${ROOT}/usr/$(get_libdir)/opengl/xorg-x11/lib/libMesaGL.so
		fi
		if [ -e "${ROOT}/usr/$(get_libdir)/libMesaGL.so" ]; then
			einfo "Removing libMesaGL.so from /usr/$(get_libdir).  See bug #47598."
			rm -f ${ROOT}/usr/$(get_libdir)/libMesaGL.so
		fi

		for f in ${ROOT}/usr/$(get_libdir)/libGL.so.* ${ROOT}/usr/$(get_libdir)/libGLcore.so.* ${ROOT}/usr/$(get_libdir)/libnvidia-tls* ${ROOT}/usr/$(get_libdir)/tls/libnvidia-tls* ; do
			[[ -e ${f} ]] && rm -f ${f}
		done
	done
	ABI="${OABI}"
	unset OABI
}

pkg_postinst() {
	local impl="$(opengl-update --get-implementation)"
	if [[ -n "${impl}" ]] ; then
		opengl-update "${impl}"
	fi
}

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die

	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ "${MLTEST/set_abi}" = "${MLTEST}" ]; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			# Install default glext.h
			insinto /usr/$(get_libdir)/opengl/global/include
			doins ${WORKDIR}/glext.h || die
			doins ${WORKDIR}/glxext.h || die
		done
		ABI="${OABI}"
		unset OABI
	else
		# Install default glext.h
		insinto /usr/$(get_libdir)/opengl/global/include
		doins ${WORKDIR}/glext.h || die
		doins ${WORKDIR}/glxext.h || die
	fi
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-2.1_pre3.ebuild,v 1.1 2005/01/26 05:59:52 eradicator Exp $

inherit multilib toolchain-funcs

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"
GLEXT="20040830"
SRC_URI="http://dev.gentoo.org/~cyfred/distfiles/glext.h-${GLEXT}.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
#Removed: ~arm ~hppa ~ia64 due to insufficient xorg-x11 version
IUSE=""
RESTRICT="multilib-pkg-force"

DEPEND="virtual/libc
	app-arch/bzip2"

RDEPEND="!x11-base/xfree86
	 !<x11-base/xorg-x11-6.8.0-r4
	 !<media-video/ati-drivers-8.8.25-r3"

src_unpack() {
	bzcat ${DISTDIR}/glext.h-${GLEXT}.bz2 > ${WORKDIR}/glext.h || die
}

pkg_preinst() {
	# It needs to be before 04multilib
	[ -f "${ROOT}/etc/env.d/09opengl" ] && mv ${ROOT}/etc/env.d/09opengl ${ROOT}/etc/env.d/03opengl

	OABI="${ABI}"
	for ABI in $(get_abi_order); do
		if [ -e "${ROOT}/usr/$(get_libdir)/opengl/xorg-x11/lib/libMesaGL.so" ]; then
			einfo "Removing libMesaGL.so from xorg-x11 profile.  See bug #47598."
			rm -f ${ROOT}/usr/$(get_libdir)/opengl/xorg-x11/lib/libMesaGL.so
		fi
		if [ -e "${ROOT}/usr/$(get_libdir)/libMesaGL.so" ]; then
			einfo "Removing libMesaGL.so from /usr/$(get_libdir).  See bug #47598."
			rm -f ${ROOT}/usr/$(get_libdir)/libMesaGL.so
		fi
	done
	ABI="${OABI}"
	unset OABI
}

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die

	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ "${MLTEST/set_abi}" = "${MLTEST}" ]; then
		OABI="${ABI}"
		for ABI in $(get_abi_order); do
			# Install default glext.h
			insinto /usr/$(get_libdir)/opengl/global/include
			doins ${WORKDIR}/glext.h || die
		done
		ABI="${OABI}"
		unset OABI
	else
		# Install default glext.h
		insinto /usr/$(get_libdir)/opengl/global/include
		doins ${WORKDIR}/glext.h || die
	fi
}

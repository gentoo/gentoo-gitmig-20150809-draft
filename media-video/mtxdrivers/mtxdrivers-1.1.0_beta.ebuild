# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mtxdrivers/mtxdrivers-1.1.0_beta.ebuild,v 1.1 2003/12/26 15:15:25 spyderous Exp $

MY_PV="${PV/_/-}"
MY_P="${PN}-rh9.0-v${MY_PV}"
DESCRIPTION="Drivers for the Matrox Parhelia and Millenium P650/P750 cards."
HOMEPAGE="http://www.matrox.com/mga/products/parhelia/home.cfm"
SRC_URI="${MY_P}.run"

LICENSE="Matrox"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"

DEPEND=">=x11-base/xfree-4.2.0
	virtual/kernel
	!mtxdrivers-pro"
S="${WORKDIR}"

pkg_nofetch() {
	einfo "You must go to: http://www.matrox.com/mga/registration/home.cfm?refid=7667"
	einfo "(for the RH9.0 drivers) and log in (or create an account) to download the"
	einfo "Matrox Parhelia drivers. Remember to right-click and use Save Link As when"
	einfo "downloading the driver."
}

pkg_setup() {
	# Force XFree86 4.3.0, 4.2.1 or 4.2.0 to be installed unless FORCE_VERSION
	# is set. Need FORCE_VERSION for 4.3.99/4.4.0 compatibility until Matrox
	# comes up with drivers (spyderous)
	local INSTALLED_X="`best_version x11-base/xfree`"
	GENTOO_X_VERSION_REVISION="${INSTALLED_X/x11-base\/xfree-}"
	GENTOO_X_VERSION="${GENTOO_X_VERSION_REVISION%-*}"
	if [ "${GENTOO_X_VERSION}" != "4.3.0" ]
	then
		if [ "${GENTOO_X_VERSION}" != "4.2.1" ]
		then
			if [ "${GENTOO_X_VERSION}" != "4.2.0" ]
			then
				if [ -n "${FORCE_VERSION}" ]
				then
					GENTOO_X_VERSION="${FORCE_VERSION}"
				else
					die "These drivers require XFree86 4.3.0, 4.2.1 or 4.2.0. Do FORCE_VERSION=version-you-want emerge ${PN} (4.3.0, 4.2.1 or 4.2.0) to force installation."
				fi
			fi
		fi
	fi
}

src_unpack() {
	tail -n 4907 ${DISTDIR}/${A} | tar xvzf -
}

src_compile() {
	export PARHELIUX="${PWD}/src"
	cd ${S}/src/kernel/parhelia
	ln -sf ../../../kernel/mtx_parhelia.o .
	cd ..
	# Can't use emake here
	make clean
	make
}

src_install() {
	dodoc README* samples/*

	# Kernel Module
	dodir /lib/modules/${KV}/kernel/drivers/video
	insinto /lib/modules/${KV}/kernel/drivers/video
	doins src/kernel/mtx.o

	# X Driver (2D)
	dodir /usr/X11R6/lib/modules/drivers
	insinto /usr/X11R6/lib/modules/drivers
	doins xfree86/${GENTOO_X_VERSION}/mtx_drv.o
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi

	einfo "Please look at /usr/share/doc/${P}/XF86Config.* for"
	einfo "X configurations for your Parhelia or Millenium P650/P750 card."

	if [ ! -d /dev/video ]
	then
		if [ -f /dev/video ]
		then
			einfo "NOTE: To be able to use busmastering, you MUST have /dev/video as"
		    einfo "a directory, which means you must remove anything there first"
			einfo "(rm -f /dev/video), and mkdir /dev/video"
		else
			mkdir /dev/video
		fi
	fi
}

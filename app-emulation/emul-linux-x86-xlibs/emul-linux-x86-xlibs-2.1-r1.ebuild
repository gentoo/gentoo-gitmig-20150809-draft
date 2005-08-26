# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-2.1-r1.ebuild,v 1.1 2005/08/26 19:21:44 eradicator Exp $

inherit multilib

DESCRIPTION="X11R6 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/emul-linux-x86-xlibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="opengl"

DEPEND=""

RDEPEND="opengl? ( app-admin/eselect-opengl )
	 virtual/libc
	 >=app-emulation/emul-linux-x86-baselibs-2.0"

S=${WORKDIR}

pkg_preinst() {
	# Check for bad symlink before installing, bug 84441.
	if [ -L /emul/linux/x86/usr/lib/X11 ]; then
		rm -f /emul/linux/x86/usr/lib/X11
	fi
}

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/

	local libdir="lib32"
	if has_multilib_profile; then
		libdir=$(get_abi_LIBDIR x86)
	fi

	dodir /usr/${libdir}/opengl
	dosym /emul/linux/x86/usr/lib/opengl/xorg-x11 /usr/${libdir}/opengl/xorg-x11
}

pkg_postinst() {
	#update GL symlinks
	if use opengl ; then
		/usr/bin/eselect opengl set --use-old
	fi
}


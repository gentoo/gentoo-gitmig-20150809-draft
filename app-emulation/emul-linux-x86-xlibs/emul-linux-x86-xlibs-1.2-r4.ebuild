# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-1.2-r4.ebuild,v 1.1 2005/02/05 09:09:43 eradicator Exp $

inherit multilib

DESCRIPTION="X11R6 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-xlibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="virtual/libc
	 >=x11-base/xorg-x11-6.8.0-r4
	 >=app-emulation/emul-linux-x86-baselibs-1.2.2-r2"

S=${WORKDIR}

src_install() {
	mkdir -p ${D}/etc/env.d/
	cp -Rpvf ${WORKDIR}/* ${D}/

	local libdir="lib32"
	if has_multilib_profile; then
		libdir=$(get_abi_LIBDIR x86)
	fi
	dodir /usr/${libdir}/opengl
	dosym /emul/linux/x86/usr/lib/opengl/xorg-x11 /usr/${libdir}/opengl/xorg-x11

	dodir /emul/linux/x86/usr/lib/X11/locale/C
	cp ${FILESDIR}/XI18N_OBJS ${D}/emul/linux/x86/usr/lib/X11/locale/C/
	cp ${FILESDIR}/XLC_LOCALE ${D}/emul/linux/x86/usr/lib/X11/locale/C/

	mv ${D}/emul/linux/x86/usr/X11R6/lib/* ${D}/emul/linux/x86/usr/lib/

	# We don't use this any more
	rm -rf ${D}/usr/X11R6
	rm -rf ${D}/emul/linux/x86/usr/X11R6
	rm -f ${D}/emul/linux/x86/usr/lib/X11

	dosed "s:^libdir=.*$:libdir=\'/emul/linux/x86/usr/lib\':" /emul/linux/x86/usr/lib/libGLU.la

	chown -R root:root ${D}
}

pkg_postinst() {
	ln -s /emul/linux/x86/usr/lib/X11/locale/lib /usr/$(get_libdir)/X11/locale/lib
}

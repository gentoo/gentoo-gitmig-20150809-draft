# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/motif-config/motif-config-0.6.ebuild,v 1.1 2005/03/22 16:18:25 lanius Exp $

inherit multilib

DESCRIPTION="Utility to change the default Motif library"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE=""

DEPEND=""

RDEPEND="app-shells/bash"

src_unpack(){
	einfo "nothing to unpack"
}

src_compile() {
	einfo "nothing to compile"
}

src_install () {
	exeinto /usr/bin
	newexe ${FILESDIR}/${P} motif-config
	dosed "s:@@LIBDIR@@:$(get_libdir):g" /usr/bin/motif-config

	# for profile
	dodir /usr/$(get_libdir)/motif
	keepdir /usr/$(get_libdir)/motif

	# bitmaps
	dodir /usr/include/X11/bitmaps
	tar -xjf ${FILESDIR}/bitmaps.tbz2 -C ${D}/usr/include/X11/bitmaps
	# bindings
	dodir /usr/$(get_libdir)/X11/bindings
	tar -xjf ${FILESDIR}/bindings.tbz2 -C ${D}/usr/$(get_libdir)/X11/bindings

	# mwm default config
	insinto /etc/X11/app-defaults
	doins ${FILESDIR}/Mwm.defaults

	insinto /etc/X11/mwm
	doins ${FILESDIR}/system.mwmrc

	dosym /etc/X11/mwm /usr/$(get_libdir)/X11/mwm
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbcomp/xkbcomp-1.0.5.ebuild,v 1.8 2009/04/16 02:09:56 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular multilib

DESCRIPTION="compile XKB keyboard description"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11
	x11-libs/libxkbfile"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install

	dodir usr/share/X11/xkb
	dosym ../../../bin/xkbcomp /usr/share/X11/xkb/xkbcomp

	# (#122214) We should create this directory here, since xkeyboard-config
	# and any other set of layouts will symlink to it.
	dodir /var/lib/xkb
	keepdir /var/lib/xkb
}

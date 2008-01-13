# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xman/xman-1.0.2.ebuild,v 1.9 2008/01/13 09:35:35 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Manual page display program for the X Window System"

KEYWORDS="~amd64 arm ~mips ~ppc ppc64 s390 sh ~sparc x86"
IUSE="xprint"

RDEPEND="xprint? ( x11-libs/libXprintUtil )"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable xprint)"

pkg_setup() {
	if use xprint; then
		if ! built_with_use x11-libs/libXaw xprint; then
			msg="You must build libXaw with xprint enabled."
			eerror ${msg}
			die ${msg}
		fi
	fi
}

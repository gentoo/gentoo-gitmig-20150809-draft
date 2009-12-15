# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xrandr/xrandr-1.3.2.ebuild,v 1.7 2009/12/15 16:22:43 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="primitive command line interface to RandR extension"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libXrandr-1.3
	x11-libs/libXrender
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install
	rm -f "${D}"/usr/bin/xkeystone
}

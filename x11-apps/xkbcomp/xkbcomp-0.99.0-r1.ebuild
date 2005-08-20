# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbcomp/xkbcomp-0.99.0-r1.ebuild,v 1.3 2005/08/20 22:30:26 lu_zero Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xkbcomp application"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libxkbfile"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install

	dodir usr/lib/X11/xkb
	dosym ../../../bin/xkbcomp /usr/lib/X11/xkb/xkbcomp
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbdata/xkbdata-0.99.1-r1.ebuild,v 1.1 2005/10/20 21:51:00 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular multilib

DESCRIPTION="X.Org xkbdata data"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-apps/xkbcomp"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install
	keepdir /var/lib/xkb
	dosym ../../../../var/lib/xkb /usr/share/X11/xkb/compiled
	echo "CONFIG_PROTECT=\"/usr/share/X11/xkb\"" > ${T}/10xkbdata
	doenvd ${T}/10xkbdata
}

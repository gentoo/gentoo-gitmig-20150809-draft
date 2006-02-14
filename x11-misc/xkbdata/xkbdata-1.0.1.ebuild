# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbdata/xkbdata-1.0.1.ebuild,v 1.5 2006/02/14 22:54:59 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular multilib

DESCRIPTION="X.Org xkbdata data"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-apps/xkbcomp
	!x11-misc/xkeyboard-config"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install
	keepdir /var/lib/xkb
	dosym ../../../../var/lib/xkb /usr/share/X11/xkb/compiled
	echo "CONFIG_PROTECT=\"/usr/share/X11/xkb\"" > ${T}/10xkbdata
	doenvd ${T}/10xkbdata
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbdata/xkbdata-0.99.0.ebuild,v 1.9 2005/09/04 08:12:41 matsuu Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular multilib

DESCRIPTION="X.Org xkbdata data"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-apps/xkbcomp"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install
	keepdir /var/lib/xkb
	dosym ../../../../var/lib/xkb /usr/$(get_libdir)/X11/xkb/compiled
}

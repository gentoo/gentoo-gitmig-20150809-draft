# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.1.5.ebuild,v 1.2 2004/01/16 19:28:55 gmsoft Exp $
inherit kde-dist

IUSE="pda"
DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86 ~ppc ~sparc hppa ~amd64 ~alpha"

DEPEND="pda? ( >=app-pda/pilot-link-0.11.1-r1 >=dev-libs/libmal-0.31 )
	~kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}" # mimelib is needed for support of some stuff with exchange servers
RDEPEND="$DEPEND"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

# reported by doctomoe on ppc
use ppc && MAKEOPTS="$MAKEOPTS -j1"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}

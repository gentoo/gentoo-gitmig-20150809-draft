# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.1.2-r1.ebuild,v 1.1 2003/07/04 16:14:26 brain Exp $
inherit kde-dist 

IUSE="pda"
DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="~x86 ~ppc ~sparc -alpha" # mark as stable only after marking stable libmal

newdepend "pda? ( >=dev-libs/pilot-link-0.11.1-r1 
				>=dev-libs/libmal-0.31 )
	dev-lang/perl
	=kde-base/kdebase-${PV}*
	~kde-base/kdenetwork-${PV}" # mimelib is needed for support of some stuff with exchange servers

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock" && PATCHES="${FILESDIR}/kdepim-3.1.2-libmal-support.diff"

# reported by doctomoe on ppc
MAKEOPTS="$MAKEOPTS -j1"
src_compile() {
        use pda && rm -f configure configure.in
		kde_src_compile myconf configure
		kde_src_compile make
}
								
src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2.2.ebuild,v 1.10 2003/01/17 08:46:31 danarmak Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86 sparc "

DEPEND="$DEPEND sys-devel/perl"

newdepend ">=dev-libs/pilot-link-0.9.0"

# doesn't compile with gcc3/glibc3.2 and will not be fixed
KDE_REMOVE_DIR="kpilot"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2.2-r1.ebuild,v 1.7 2003/08/30 10:19:25 liquidx Exp $
inherit kde-dist eutils

IUSE=""
DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86 sparc ppc"

newdepend ">=app-pda/pilot-link-0.9.0
	dev-lang/perl"

# doesn't compile with gcc3/glibc3.2 and will not be fixed
KDE_REMOVE_DIR="kpilot"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${FILESDIR}/post-${PV}-${PN}.diff
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.3.0.ebuild,v 1.10 2004/10/06 11:51:21 gmsoft Exp $
inherit eutils kde-dist

IUSE=""
DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
KEYWORDS="x86 ~amd64 sparc ppc hppa"

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND
	dev-util/cvs"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/3.3.0-kbabel.diff
}

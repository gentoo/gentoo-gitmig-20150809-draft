# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.3.0.ebuild,v 1.7 2004/09/15 02:33:12 weeve Exp $
inherit eutils kde-dist

IUSE=""
DESCRIPTION="KDE SDK: kbabel, ..."
KEYWORDS="x86 ~amd64 sparc ppc"

DEPEND="!dev-util/kcachegrind
	x86? ( >=dev-util/calltree-0.9.1 )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND
	dev-util/cvs"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/3.3.0-kbabel.diff
}

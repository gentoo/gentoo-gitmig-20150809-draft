# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.3.2.ebuild,v 1.7 2006/02/16 09:32:23 flameeyes Exp $
inherit eutils kde-dist

IUSE=""
DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
KEYWORDS="x86 amd64 sparc ppc hppa"

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz"

RDEPEND="$DEPEND
	dev-util/cvs"

DEPEND="${RDEPEND}
	sys-devel/flex"

src_unpack()
{
	kde_src_unpack
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.3.1.ebuild,v 1.4 2005/01/12 18:44:13 gustavoz Exp $
inherit eutils kde-dist

IUSE=""
DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
KEYWORDS="x86 ~amd64 sparc ~ppc ~hppa"

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND
	dev-util/cvs"

src_unpack()
{
	kde_src_unpack
}

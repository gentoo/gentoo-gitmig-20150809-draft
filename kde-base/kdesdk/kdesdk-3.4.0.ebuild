# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.4.0.ebuild,v 1.3 2005/04/03 21:22:04 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="subversion"

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz
	sys-devel/flex
	subversion? ( dev-util/subversion )"

RDEPEND="${DEPEND}
	dev-util/cvs"

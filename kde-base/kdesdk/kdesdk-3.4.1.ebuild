# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.4.1.ebuild,v 1.7 2006/02/16 09:32:23 flameeyes Exp $

inherit kde-dist

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="subversion"

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz
	subversion? ( dev-util/subversion )"

RDEPEND="${DEPEND}
	dev-util/cvs"

DEPEND="${RDEPEND}
	sys-devel/flex"

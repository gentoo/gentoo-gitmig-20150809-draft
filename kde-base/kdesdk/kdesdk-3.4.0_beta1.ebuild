# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.4.0_beta1.ebuild,v 1.1 2005/01/14 00:19:31 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

KEYWORDS="~x86"
IUSE=""

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="${DEPEND}
	dev-util/cvs"

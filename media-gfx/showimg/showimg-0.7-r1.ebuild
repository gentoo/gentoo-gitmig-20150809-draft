# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.7-r1.ebuild,v 1.2 2002/10/04 05:45:38 vapier Exp $
inherit kde-base

need-kde 2.2

S=${WORKDIR}/${P}
DESCRIPTION="ShowImg is a feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.bz2"
HOMEPAGE="http://www.jalix.org/projects/showimg/"
newdepend "=kde-base/kdebase-2.2*"

PATCHES="${FILESDIR}/${P}-gcc3.diff"

LICENSE="GPL-2"
KEYWORDS="x86"

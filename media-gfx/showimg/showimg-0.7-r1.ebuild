# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.7-r1.ebuild,v 1.4 2003/04/25 13:00:24 vapier Exp $

inherit kde-base
need-kde 2.2

DESCRIPTION="feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.bz2"
HOMEPAGE="http://www.jalix.org/projects/showimg/"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "=kde-base/kdebase-2.2*"

PATCHES="${FILESDIR}/${P}-gcc3.diff"

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.7.ebuild,v 1.7 2002/07/23 05:18:07 seemant Exp $

inherit kde-base || die

need-kde 2.2

S=${WORKDIR}/${P}
DESCRIPTION="ShowImg is a feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.bz2"
HOMEPAGE="http://www.jalix.org/projects/showimg/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.7.ebuild,v 1.6 2002/07/11 06:30:28 drobbins Exp $

inherit kde-base || die

need-kde 2.2

S=${WORKDIR}/${P}

LICENSE="GPL-2"
DESCRIPTION="ShowImg is a feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.bz2"
HOMEPAGE="http://www.jalix.org/projects/showimg/"



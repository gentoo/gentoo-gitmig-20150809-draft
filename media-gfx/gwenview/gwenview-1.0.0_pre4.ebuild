# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gwenview/gwenview-1.0.0_pre4.ebuild,v 1.1 2003/11/17 19:53:52 lanius Exp $

inherit kde-base
need-kde 3

MY_P="${P/_/}"

DESCRIPTION="image viewer for KDE"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://gwenview.sourceforge.net/"

S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~x86"

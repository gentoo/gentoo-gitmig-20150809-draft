# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gwenview/gwenview-0.16.2.ebuild,v 1.1 2003/02/18 17:50:18 hannes Exp $
inherit kde-base
need-kde 3

newdepend ">=kde-base/kdebase-3.0"

IUSE=""
DESCRIPTION="Gwenview is an image viewer for KDE"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gwenview.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.3.ebuild,v 1.5 2005/01/14 23:47:00 danarmak Exp $

inherit kde

DESCRIPTION="feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.gz"
HOMEPAGE="http://www.jalix.org/projects/showimg/"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"

IUSE=""
SLOT="0"

DEPEND="|| ( kde-base/kdebase-meta kde-base/kdebase )"
RDEPEND="|| ( kde-base/kdebase-meta kde-base/kdebase )"
need-kde 3.1

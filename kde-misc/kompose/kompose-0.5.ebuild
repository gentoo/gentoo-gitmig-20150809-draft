# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kompose/kompose-0.5.ebuild,v 1.2 2004/11/23 15:50:26 carlo Exp $

inherit kde

DESCRIPTION="A KDE fullscreen task manager."
HOMEPAGE="http://kompose.berlios.de"
SRC_URI="http://download.berlios.de/kompose/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="media-libs/imlib2"
RDEPEND="media-libs/imlib2"
need-kde 3.2

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kompose/kompose-0.3.ebuild,v 1.2 2004/08/03 11:41:49 dholm Exp $

inherit kde

DESCRIPTION="A KDE fullscreen task manager."
HOMEPAGE="http://kde-apps.org/content/show.php?content=14422"
SRC_URI="http://kde-apps.org/content/files/14422-${P}.tar.bz2"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

need-kde 3.2
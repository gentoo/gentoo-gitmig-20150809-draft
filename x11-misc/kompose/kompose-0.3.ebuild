# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kompose/kompose-0.3.ebuild,v 1.4 2004/09/02 22:49:41 pvdabeel Exp $

inherit kde

DESCRIPTION="A KDE fullscreen task manager."
HOMEPAGE="http://kde-apps.org/content/show.php?content=14422"
SRC_URI="http://kde-apps.org/content/files/14422-${P}.tar.bz2"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~amd64"
IUSE=""

need-kde 3.2
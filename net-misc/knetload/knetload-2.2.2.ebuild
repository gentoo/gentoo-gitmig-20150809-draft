# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-2.2.2.ebuild,v 1.5 2004/10/17 12:40:04 absinthe Exp $

inherit kde

DESCRIPTION="A Network applet for KDE3"
HOMEPAGE="http://flameeyes.web.ctonet.it/kdeapps.html#knetload"
SRC_URI="http://flameeyes.web.ctonet.it/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc amd64 ~ppc"
IUSE=""

need-kde 3

myconf="--enable-libsuffix="

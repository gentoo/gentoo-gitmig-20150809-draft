# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-2.2.2.ebuild,v 1.2 2004/06/21 19:05:36 hansmi Exp $

IUSE=""

inherit kde

need-kde 3

KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="GPL-2"
DESCRIPTION="A Network applet for KDE3"
SRC_URI="http://flameeyes.web.ctonet.it/files/${P}.tar.bz2"
HOMEPAGE="http://flameeyes.web.ctonet.it/kdeapps.html#knetload"

myconf="--enable-libsuffix="

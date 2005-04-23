# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-2.3.ebuild,v 1.5 2005/04/23 02:05:36 flameeyes Exp $

inherit kde

DESCRIPTION="A Network applet for KDE3"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/kdeapps#knetload"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~ppc"
IUSE=""

need-kde 3

myconf="--enable-libsuffix="

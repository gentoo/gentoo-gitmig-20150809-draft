# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-1.99.ebuild,v 1.10 2004/06/28 19:56:39 carlo Exp $

inherit kde

DESCRIPTION="A Network applet for KDE3"
HOMEPAGE="http://people.debian.org/~bab/knetload/"
SRC_URI="http://people.debian.org/~bab/knetload/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"
IUSE=""

need-kde 3

myconf="--enable-libsuffix="

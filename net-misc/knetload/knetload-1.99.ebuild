# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-1.99.ebuild,v 1.7 2004/03/14 17:27:29 mr_bones_ Exp $

IUSE=""

inherit kde

need-kde 3

KEYWORDS="x86 sparc ~amd64"
LICENSE="GPL-2"
DESCRIPTION="A Network applet for KDE3"
SRC_URI="http://people.debian.org/~bab/knetload/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~bab/knetload/"

myconf="--enable-libsuffix="

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kcpuload/kcpuload-1.99.ebuild,v 1.7 2004/03/21 19:42:50 weeve Exp $

IUSE=""

inherit kde

need-kde 3

DESCRIPTION="A CPU applet for KDE3"
SRC_URI="http://people.debian.org/~bab/kcpuload/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~bab/kcpuload/"


LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

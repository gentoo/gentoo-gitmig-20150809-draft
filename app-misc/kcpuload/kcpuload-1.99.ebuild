# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kcpuload/kcpuload-1.99.ebuild,v 1.2 2003/02/13 09:02:39 vapier Exp $

IUSE=""

inherit kde-base || die

need-kde 3

DESCRIPTION="A CPU applet for KDE3"
SRC_URI="http://people.debian.org/~bab/kcpuload/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~bab/kcpuload/"


LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

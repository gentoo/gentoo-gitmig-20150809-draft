# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/kdar/kdar-1.0.0.ebuild,v 1.1 2004/02/10 17:05:16 matsuu Exp $

inherit kde
need-kde 3.1

MY_P=${P/_/"-"}
S=${WORKDIR}/${MY_P}

DESCRIPTION="the KDE Disk Archiver"
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdar/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

newdepend ">=app-arch/dar-2.1.0"

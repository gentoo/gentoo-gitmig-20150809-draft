# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/easydiff/easydiff-0.3.1_pre20040920.ebuild,v 1.1 2004/09/24 01:08:05 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/EasyDiff

DESCRIPTION="GNUstep app that lets you easily see the differences between two text files."
HOMEPAGE="http://www.collaboration-world.com/easydiff/"
LICENSE="GPL-2"

SRC_URI="mirrror://gentoo/${P}.tar.gz"
KEYWORDS="~x86"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"


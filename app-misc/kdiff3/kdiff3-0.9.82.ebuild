# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdiff3/kdiff3-0.9.82.ebuild,v 1.4 2004/04/03 23:08:14 pylon Exp $

inherit kde
need-kde 3

DESCRIPTION="KDE-based frontend to diff3"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"
HOMEPAGE="http://kdiff3.sourceforge.net/"

KEYWORDS="~x86 amd64 ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="nomirror"

RDEPEND="$RDEPEND sys-apps/diffutils"

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/karamba/karamba-0.17.ebuild,v 1.5 2004/06/19 14:25:16 pyrania Exp $

inherit kde

need-kde 3

IUSE="xmms"
DESCRIPTION="A KDE program that displays a lot of various information right on your desktop."
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

newdepend ">=kde-base/kdelibs-3.1
	xmms? ( >=media-sound/xmms-1.2.7 )
	>=sys-apps/portage-2.0.26"


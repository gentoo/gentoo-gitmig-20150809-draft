# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kxicq2/kxicq2-0.7.6.20020728.ebuild,v 1.1 2002/08/03 10:12:54 danarmak Exp $
inherit kde-base

need-kde 3

S=${WORKDIR}/kxicq2
LICENSE="GPL-2"
KEYWORDS="x86"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.kxicq.org"
DESCRIPTION="KDE ICQ Client, using the ICQ2000 protocol"

PATCHES="$FILESDIR/$P-gcc3.diff"

newdepend "media-libs/xpm"

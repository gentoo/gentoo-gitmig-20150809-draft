# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/serlook/serlook-0.2.4.ebuild,v 1.2 2004/06/04 09:12:55 dholm Exp $

inherit kde

need-kde 3

MY_P=${P}"-KDE3"

DESCRIPTION="serlook is a tool aimed to inspect and debug serial line data traffic"
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

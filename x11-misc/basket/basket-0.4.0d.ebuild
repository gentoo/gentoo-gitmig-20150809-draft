# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.4.0d.ebuild,v 1.4 2004/09/02 22:49:40 pvdabeel Exp $

inherit kde

need-kde 3.1
need-qt 3

IUSE=""
DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://les83plus.fr.st/sebastien.laout/basket"
SRC_URI="http://les83plus.free.fr/sebastien.laout/basket/downloads/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc"
S=${WORKDIR}/${P/.0d//}

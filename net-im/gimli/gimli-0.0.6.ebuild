# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gimli/gimli-0.0.6.ebuild,v 1.1 2003/04/30 23:54:11 bass Exp $

inherit gnome2

DESCRIPTION="Instant Messenger client for the GNOME Desktop.."
SRC_URI="mirror://sourceforge/gimli/${P}.tar.gz"
HOMEPAGE="http://gimli.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x11-libs/libelysium
		x11-libs/libelysiumui"

#RDEPEND=""
S=${WORKDIR}/${P}
